extends Node

@onready var gameManager = $".."
@onready var fish1: PackedScene = preload("res://objects/fish.tscn")

const minTime: float = 2
const maxTime: float = 5

var delay: float;
var lastSpawn: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SetRandomDelay()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("runTime: ", gameManager.runTime, "   lastSpawn: ", lastSpawn, "   delay: ", delay)
	if (lastSpawn + delay <= gameManager.runTime):
		
		#spawn object
		var instance: Node2D = fish1.instantiate()
		add_child(instance)
		instance.transform.origin.x += get_child_count() * 10
		
		# reset timer vars
		lastSpawn = gameManager.runTime
		SetRandomDelay()


func SetRandomDelay() -> void:
	delay = randf_range(minTime, maxTime)
