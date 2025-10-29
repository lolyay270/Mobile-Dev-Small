"""
This script allows any button to load any scene
"""

extends Button

# scene can be changed on each button this is added to, default mainMenu
@export var sceneToLoad: String = "res://scenes/mainMenu.tscn"


func _on_button_up() -> void:
	get_tree().change_scene_to_file(sceneToLoad)
	print("attempted to load ", sceneToLoad)
