"""
This script manages high score checking, and displaying both scores in the gameOver scene
"""

extends Node

@onready var finalScoreDisplay: Label = $BG/score
@onready var highscoreDisplay = $"BG/high score"
@onready var newHSBanner = $"BG/new high score"
@onready var bannerAnimate: AnimationPlayer = $"BG/new high score/AnimationPlayer"

@onready var scoreManager = $"/root/Game/Score/Value"



func _ready() -> void:
	if scoreManager.score > GameManager.highScore:
		manageHighScore()
	
	scoreManager.get_parent().hide() #hide the scoreDisplay
	finalScoreDisplay.text = "SCORE: " + str(scoreManager.score)
	highscoreDisplay.text = "HIGH SCORE: " + str(GameManager.highScore)


func _on_new_game_button_up() -> void:
	get_tree().reload_current_scene()


func manageHighScore():
	GameManager.highScore = scoreManager.score
	SaveData.save_game()
	
	newHSBanner.show()
	bannerAnimate.play("sizePulse")
