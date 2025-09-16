"""
This script resets GameManager (a singleton) to its default values
when a new run of the game begins 
"""

extends Node

@onready var scoreDisplay

func _ready() -> void:
	GameManager.ResetToDefault()
	
