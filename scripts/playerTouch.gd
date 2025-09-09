extends Node2D

@onready var net = $net
@onready var trigger: CollisionPolygon2D = $net/Area2D/CollisionPolygon2D

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
		SetNetStatus(true)
	
	if event.is_action_released("press"):
		SetNetStatus(false)


func SetNetStatus(isActive: bool):
	net.set_visible(isActive) #toggle vision
	trigger.set_disabled(!isActive) #toggle collider
	pressed = isActive


func HandlePlayStateUpdate():
	if !GameManager.isPlaying:
		self.queue_free()
