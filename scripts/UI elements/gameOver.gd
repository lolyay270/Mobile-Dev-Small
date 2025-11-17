"""
This script manages player game stat checking and displaying when a run is over
And hiding UI elements that are no longer needed
"""

extends Node

@onready var finalScoreDisplay: Label = $score
@onready var highscoreDisplay: Label = $"high score"
@onready var newHSBanner = $"new high score"
@onready var bannerAnimate: AnimationPlayer = $"new high score/AnimationPlayer"
@onready var timeDisplay: Label = $time

@onready var scoreManager = $"/root/Game/Score/Value"
@onready var runningTime = $"/root/Game/Time"



func _ready() -> void:
	# hide UI elements from game scene
	scoreManager.get_parent().hide()
	runningTime.hide()
	
	# update UI in gameOver to be correct
	if scoreManager.score > GameManager.highScore:
		manageHighScore()
	finalScoreDisplay.text = "SCORE: " + str(scoreManager.score)
	timeDisplay.text = GameManager.humanReadableRunTime()


func manageHighScore():
	GameManager.highScore = scoreManager.score
	SaveData.save_game()
	
	highscoreDisplay.UpdateScore(scoreManager.score)
	newHSBanner.show()
	bannerAnimate.play("sizePulse")
