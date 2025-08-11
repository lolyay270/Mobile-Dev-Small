extends Node

@onready var viewportSize = get_viewport().size

@onready var gameManager = $".."
@onready var fish1: PackedScene = preload("res://objects/fish.tscn")

const minTime: float = .1
const maxTime: float = 1

const sideRatio: float = 0.5 # 50% left side spawns, 50% right
const spawnZoneCenterOverlap: float = 0.1 # percent of screen that can have both sides spawn in
const topScreenPadding: float = 0.1 # percent of top of screen that the fish cant jump into
var ySpawnPos: float # spawn location of fish object
var jumpHeightMax: float # how much of the screen height the fish is allowed to jump
const minDistances: Vector2 = Vector2(0.2, 0.4) # percent of screen that is minimum distances traveled

var delay: float
var lastSpawn: float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SetRandomDelay()
	
	viewportSize = Vector2(get_viewport().size)
	ySpawnPos = viewportSize.y # fish 0,0 is top left screen corner
	jumpHeightMax = viewportSize.y * topScreenPadding


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (lastSpawn + delay <= gameManager.runTime):
		
		#spawn object
		var fish = fish1.instantiate()
		var path: Path2D = fish.get_child(0)
		
		add_child(fish)
		
		ChangeFishSpawn(fish)
		ChangeFishEnd(fish, path)
		
		#fish.Start()
		
		# reset timer vars
		lastSpawn = gameManager.runTime
		SetRandomDelay()


# move where the fish spawns/jumps from
func ChangeFishSpawn(fish: Node2D):
	#left or right half spawn?
	var side = randf()
	var xMin
	var xMax
	
	# spawn position (within the left/right halfs of screen) randomisation
	if (side < sideRatio): #spawn left
		xMin = 0 #left wall
		xMax = viewportSize.x / 2 + viewportSize.x * spawnZoneCenterOverlap
		fish.isLeftSpawn = true
	
	else: #spawn right
		fish.isLeftSpawn = false
		fish.scale.x *= -1 # flip whole fish object to jump to the left
		xMin = viewportSize.x / 2 - viewportSize.x * spawnZoneCenterOverlap
		xMax = viewportSize.x #right wall
	
	var xPos = randf_range(xMin, xMax)
	fish.transform.origin = Vector2(xPos, ySpawnPos)


func ChangeFishEnd(fish: Node2D, path: Path2D):
	fish
	var xMaxDist
	var yDist 
	
	if (fish.isLeftSpawn):
		xMaxDist = viewportSize.x - fish.position.x
		yDist = jumpHeightMax
	
	else:
		xMaxDist = fish.position.x
		yDist = jumpHeightMax * -1
	
	fish.ChangePath(xMaxDist, yDist)

func SetRandomDelay() -> void:
	delay = randf_range(minTime, maxTime)
