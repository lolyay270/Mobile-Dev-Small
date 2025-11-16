"""
This script manages spawning an object at random intervals
What type, spawn location, and path each object has
"""


extends Node

@onready var viewportSize = get_viewport().size
@onready var objectPrefab: PackedScene = preload("res://objects/pathingObject.tscn")

const minTime: float = .1
const maxTime: float = 1

const sideRatio: float = 0.5 # 50% left side spawns, 50% right
const spawnZoneCenterOverlap: float = 0.0 # percent of screen that can have both sides spawn in
const topScreenPadding: float = -0.1 # percent of top of screen that the fish cant jump into
var ySpawnPos: float # spawn location of fish object
var jumpHeightMax: float # how much of the screen height the fish is allowed to jump
var minDistances: Vector2 # percent of screen that is minimum distances traveled

const bombChance: float = 0.05 # chance of bomb spawning 

var delay: float
var lastSpawn: float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SetRandomDelay()
	
	viewportSize = Vector2(get_viewport().size)
	ySpawnPos = viewportSize.y + 200 # fish 0,0 is top left screen corner
	jumpHeightMax = ySpawnPos * topScreenPadding
	minDistances = Vector2(0.4 * viewportSize.x, viewportSize.y - (0.4 * ySpawnPos)) #top of screen is 0, bottom is 720


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (lastSpawn + delay <= GameManager.runTime):
		
		#spawn object
		var fish = objectPrefab.instantiate()
		var path: Path2D = fish.get_child(0)
		var pathFollow: PathFollow2D = path.get_child(0)
		
		self.add_child(fish)
		
		RandomType(fish)
		ChangeFishSpawn(fish)
		ChangeFishEnd(fish, path)
		
		pathFollow.Start()
		
		# reset timer vars
		lastSpawn = GameManager.runTime
		SetRandomDelay()


# move where the fish spawns/jumps from
func ChangeFishSpawn(fish: Node2D):
	#left or right half spawn?
	var side = randf()
	var xMin
	var xMax
	
	# spawn position (within the left/right halfs of screen) randomisation
	if (side < sideRatio): #spawn left
		xMin = 0 
		xMax = viewportSize.x / 2 + viewportSize.x * spawnZoneCenterOverlap
		fish.stats.isLeftSpawn = true
	
	else: #spawn right
		fish.stats.isLeftSpawn = false
		fish.scale.x *= -1 # flip whole fish object to jump to the left
		xMin = viewportSize.x / 2 - viewportSize.x * spawnZoneCenterOverlap 
		xMax = viewportSize.x 
	
	var xPos = randf_range(xMin, xMax)
	fish.transform.origin = Vector2(xPos, ySpawnPos)


func ChangeFishEnd(fish: Node2D, path: Path2D):
	var xMaxDist
	
	if (fish.stats.isLeftSpawn):
		xMaxDist = viewportSize.x - fish.position.x
	else:
		xMaxDist = fish.position.x
	
	var xMinDist = minDistances.x
	var xDist = randf_range(xMinDist, xMaxDist)
	var yDist = randf_range(minDistances.y, jumpHeightMax)
	
	path.ChangePath(xDist, yDist)


func RandomType(fish: Node2D):
	var rand = randf()
	var newType: Resource
	
	if rand < bombChance:
		newType = GameManager.rockResource
	else:
		rand = randi_range(1, GameManager.fishResources.size())
		newType = GameManager.fishResources[rand - 1]
	fish.setStats(newType)


func SetRandomDelay() -> void:
	delay = randf_range(minTime, maxTime)
