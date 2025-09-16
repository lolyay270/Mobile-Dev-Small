extends Node

@onready var scoreDisplay: Label = $BG/score

func _ready() -> void:
	scoreDisplay.text = "SCORE: " + str(GameManager.score)


func _on_new_game_button_up() -> void:
	get_tree().reload_current_scene()
