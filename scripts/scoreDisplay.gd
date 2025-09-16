"""
This script manages the display and text of the score on screen
"""

extends Label

func _ready() -> void:
	GameManager.scoreUpdated.connect(UpdateText)
	GameManager.playStateUpdated.connect(UpdateDisplay)


func UpdateText():
	self.text = str(GameManager.score)


func UpdateDisplay():
	self.visible = GameManager.isPlaying
