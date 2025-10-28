extends Node

@onready var finalScoreDisplay: Label = $BG/score
@onready var scoreManager = $"/root/Game/Score/Value"

func _ready() -> void:
	scoreManager.get_parent().hide() #hide the scoreDisplay
	finalScoreDisplay.text = "SCORE: " + str(scoreManager.score)


func _on_new_game_button_up() -> void:
	get_tree().reload_current_scene()
