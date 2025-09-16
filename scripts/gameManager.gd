extends Node

@export var isPlaying: bool = true
@export var runTime: float = 0 #used for fish spawning

#signal is equivalent to unity event
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


func UpdatePlayState(value: bool):
	isPlaying = value
	playStateUpdated.emit()


func ResetToDefault():
	UpdatePlayState(true)
	runTime = 0
