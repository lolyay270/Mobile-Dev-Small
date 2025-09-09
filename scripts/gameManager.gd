extends Node

@export var isPlaying: bool = true
@export var score: int = 0
@export var runTime: float = 0

#signal is equivalent to unity event
signal scoreUpdated 
signal playStateUpdated

enum ObjectTypes {
	Bomb,
	Rasbora,
	Gourami,
	Tetra
}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	runTime += delta


func UpdateScore(change: int):
	score += change
	scoreUpdated.emit()


func UpdatePlayState(value: bool):
	isPlaying = value
	playStateUpdated.emit()
