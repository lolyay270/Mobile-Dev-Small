extends Node

@onready var viewportSize = get_viewport().size

@onready var gameManager = $".."
@onready var fish1: PackedScene = preload("res://objects/fish.tscn")

const minTime: float = .1
const maxTime: float = 1

const sideRatio: float = 0.5 # 50% left side spawns, 50% right
const spawnZonePadding: float = 0.05 # percent of screen around each spawn zone that cannot be spawned in
const ySpawnPos: float = 0 # spawn location of fish below the screen

var delay: float;
var lastSpawn: float = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SetRandomDelay()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	viewportSize = Vector2(get_viewport().size)
	#print("runTime: ", gameManager.runTime, "   lastSpawn: ", lastSpawn, "   delay: ", delay)
	if (lastSpawn + delay <= gameManager.runTime):
		#spawn object
		var instance = fish1.instantiate()
		add_child(instance)
		
		#left half or right spawn?
		var side = randf()
		var posMin
		var posMax
		
		if (side < sideRatio):
			instance.spawnLeft = true;
			posMin = viewportSize * spawnZonePadding
			posMax = (viewportSize / 2) - posMin
		else:
			instance.spawnLeft = false;
			# posMin = 
			# posMax = 
		
		var xPos = randf_range(posMin, posMax)
		instance.transform.origin = Vector2(xPos, ySpawnPos)
		
		# reset timer vars
		lastSpawn = gameManager.runTime
		SetRandomDelay()


func SetRandomDelay() -> void:
	delay = randf_range(minTime, maxTime)
