extends Node

@onready var scoreDisplay: Label = $BG/score

func _ready() -> void:
	scoreDisplay.text = "SCORE: " + str(GameManager.score)
