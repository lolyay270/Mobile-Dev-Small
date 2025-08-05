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
	ySpawnPos = viewportSize.y + 250


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	viewportSize = Vector2(get_viewport().size)

	if (lastSpawn + delay <= gameManager.runTime):
		
		#spawn object
		var fish = fish1.instantiate()
		add_child(fish)
		
		#GiveFishRandomValues(fish)
		
		#fish.Start()
		
		# reset timer vars
		lastSpawn = gameManager.runTime
		SetRandomDelay()


func GiveFishRandomValues(fish):
	#left half or right spawn?
	var side = randf()
	var posMin
	var posMax
	
	# spawn position (within the left/right halfs of screen) randomisation
	if (side < sideRatio):
		fish.spawnLeft = true
		posMin = viewportSize.x * spawnZonePadding
		posMax = (viewportSize.x / 2) - spawnZonePadding
	else:
		fish.spawnLeft = false
		posMin = (viewportSize.x / 2) + spawnZonePadding
		posMax = viewportSize.x - (viewportSize.x * spawnZonePadding) 
	
	var xPos = randf_range(posMin, posMax)
	fish.transform.origin = Vector2(xPos, ySpawnPos)
	
	if (fish.spawnLeft):
		fish.horDistance = viewportSize.x - xPos - spawnZonePadding
	else:
		fish.horDistance = xPos - spawnZonePadding
	
	fish.vertDistance = viewportSize.y - spawnZonePadding
	fish.ySpawnPos = ySpawnPos

func SetRandomDelay() -> void:
	delay = randf_range(minTime, maxTime)
