"""
This script controls when splash particle effects are created
"""

extends CPUParticles2D

@onready var game = $"/root/Game"
@onready var fish: PathFollow2D = $".."
@onready var splashImg: CompressedTexture2D = preload("res://assets/waterDrop.png")

var fishYPos: float
var fishState: int = 0 # 0 for before jump, 1 for in air, 2 for returned to water

func _ready() -> void:
	self.texture = splashImg
	self.scale_amount_min = 1
	self.scale_amount_max = 1.5



func _process(delta: float) -> void:
	fishYPos = fish.global_position.y
	
	#leaving water
	if (IsFishInAir() && fishState == 0):
		fishState = 1
		SplashWater()
	
	#entering water again
	elif (!IsFishInAir() && fishState == 1):
		fishState = 2
		SplashWater()


func IsFishInAir() -> bool:
	return fishYPos < game.viewportSize.y - game.edgeScreenPaddingPx


func SplashWater():
	self.emitting = true
