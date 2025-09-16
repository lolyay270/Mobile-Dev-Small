"""
This script manages the display and text of the score on screen
"""

extends Label

@export var score: int = 0

func _ready() -> void:
	GameManager.playStateUpdated.connect(UpdateDisplay)


func UpdateScore(change: int):
	score += change
	self.text = str(score)


func UpdateDisplay():
	self.visible = GameManager.isPlaying
