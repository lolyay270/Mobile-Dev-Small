"""
This script manages the player's touch during game play, if it is active, and if it is swiping upwards
"""

extends Node2D

@onready var net = $net

#how many of the last frames to calc if the touch is moving up
const FRAMES_TO_SAVE: int = 5

var pressed: bool = false
var lastFramesYPos: Array[float] = [] #holds the last few frames Y pos, FIFO system

#determines if the mouse has been moving up (lower in y values) the last few frames
@export var canCatch: bool = false 

func _ready() -> void:
	net.hide()
	GameManager.playStateUpdated.connect(HandlePlayStateUpdate)


func _process(delta: float) -> void:
	if pressed:
		self.global_position = get_global_mouse_position()
		CheckUpSwipe()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("press"):
		self.global_position = event.position
		net.ChangeStatus(true)
		pressed = true
	
	if event.is_action_released("press"):
		net.ChangeStatus(false)
		pressed = false


func CheckUpSwipe():
	#save the most recent y pos, FIFO system
	lastFramesYPos.append(get_global_mouse_position().y)
	if lastFramesYPos.size() > FRAMES_TO_SAVE:
		lastFramesYPos.remove_at(0)
	
	var upwardCount = 0
	
	for i in lastFramesYPos.size() - 1:
		if lastFramesYPos[i] > lastFramesYPos[i + 1]: #moving upwards on screen
			upwardCount += 1
		else:
			canCatch = false
	
	if upwardCount == FRAMES_TO_SAVE - 1:
		canCatch = true


func HandlePlayStateUpdate():
	if !GameManager.isPlaying:
		self.queue_free()
