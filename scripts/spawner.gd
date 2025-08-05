extends Node

@onready var viewportSize = get_viewport().size

@onready var gameManager = $".."
@onready var fish1: PackedScene = preload("res://objects/fish.tscn")

const minTime: float = .1
const maxTime: float = 1

const sideRatio: float = 0.5 # 50% left side spawns, 50% right
const spawnZonePadding: float = 0.1 # percent of screen around each spawn zone that cannot be spawned in
var ySpawnPos: float # spawn location of fish below the screen

var delay: float;
var lastSpawn: float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SetRandomDelay()
	
	viewportSize = Vector2(get_viewport().size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (lastSpawn + delay <= gameManager.runTime):
		
		#spawn object
		var fish = fish1.instantiate()
		add_child(fish)
		
		ChangeFishSpawn(fish)
		ChangeFishEnd(fish)
		
		#fish.Start()
		
		# reset timer vars
		lastSpawn = gameManager.runTime
		SetRandomDelay()


# move where the fish spawns/jumps from
func ChangeFishSpawn(fish: Path2D):
	#left or right half spawn?
	var side = randf()
	var xMin
	var xMax
	var yMin # y = 0 is top of screen
	var pathFollow = fish.get_child(0) # get PathFollow2D
	
	# spawn position (within the left/right halfs of screen) randomisation
	if (side < sideRatio): #spawn left
		xMin = 0 
		xMax = (viewportSize.x / 2)
	else: #spawn right
		fish.scale.x *= -1 # flip whole fish object to jump to the left
		
		#THESE VALUES NEED ADJUSTING!!!
		xMin = viewportSize.x + (viewportSize.x / 2) 
		xMax = viewportSize.x * 2
	
	var xPos = randf_range(xMin, xMax)
	fish.transform.origin = Vector2(xPos, 0)


func ChangeFishEnd(fish: Path2D):
	pass

func SetRandomDelay() -> void:
	delay = randf_range(minTime, maxTime)
