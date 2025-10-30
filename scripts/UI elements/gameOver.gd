"""
This script manages high score checking, and displaying both scores in the gameOver scene
"""

extends Node

@onready var finalScoreDisplay: Label = $score
@onready var highscoreDisplay: Label = $"high score"
@onready var newHSBanner = $"new high score"
@onready var bannerAnimate: AnimationPlayer = $"new high score/AnimationPlayer"

@onready var scoreManager = $"/root/Game/Score/Value"



func _ready() -> void:
	if scoreManager.score > GameManager.highScore:
		manageHighScore()
	
	scoreManager.get_parent().hide() #hide the scoreDisplay
	finalScoreDisplay.text = "SCORE: " + str(scoreManager.score)


func manageHighScore():
	GameManager.highScore = scoreManager.score
	SaveData.save_game()
	
	highscoreDisplay.UpdateScore(scoreManager.score)
	newHSBanner.show()
	bannerAnimate.play("sizePulse")
