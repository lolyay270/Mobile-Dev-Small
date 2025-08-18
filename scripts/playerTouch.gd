extends Node2D

@onready var net = $net
var pressed: bool = false

func _ready() -> void:
	net.hide()

func _process(delta: float) -> void:
	if pressed:
		self.global_position = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("press"):
		self.global_position = event.position
		net.show()
		pressed = true
	
	if event.is_action_released("press"):
		net.hide()
		pressed = false
