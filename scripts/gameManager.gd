extends Node

var isPlaying: bool = true

@export var score: int = 0
@export var health: int
var maxHealth = 3

@export var runTime: float = 0

#signal is equivalent to unity event
signal scoreUpdated 
signal healthUpdated

enum ObjectTypes {
	Bomb,
	Rasbora,
	Gourami,
	Tetra
}

func _ready() -> void:
	health = maxHealth


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isPlaying:
		runTime += delta


func UpdateScore(change: int):
	score += change
	scoreUpdated.emit()


func UpdateHealth(change: int):
	health += change
	healthUpdated.emit()
