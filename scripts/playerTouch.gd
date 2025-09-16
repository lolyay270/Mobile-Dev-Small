extends Node2D

@onready var net = $net

var pressed: bool = false

func _ready() -> void:
	net.hide()
	GameManager.playStateUpdated.connect(HandlePlayStateUpdate)


func _process(delta: float) -> void:
	if pressed:
		self.global_position = get_global_mouse_position()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("press"):
		self.global_position = event.position
		net.ChangeStatus(true)
		pressed = true
	
	if event.is_action_released("press"):
		net.ChangeStatus(false)
		pressed = false


func HandlePlayStateUpdate():
	if !GameManager.isPlaying:
		self.queue_free()
