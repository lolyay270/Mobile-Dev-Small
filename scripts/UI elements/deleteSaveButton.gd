extends Node

@onready var confirmArea: ColorRect = $"are you sure"


func _on_toggle_button_up() -> void:
	confirmArea.visible = !confirmArea.visible


func _on_yes_button_up() -> void:
	SaveData.clearSaveData()
	confirmArea.visible = false


func _on_no_button_up() -> void:
	confirmArea.visible = false
