extends Button

var menuScene: PackedScene = preload("res://scenes/mainMenu.tscn")


func _on_button_up() -> void:
	get_tree().change_scene_to_packed(menuScene)
