extends Control

var isPlaying: bool = true
@export var runTime: float = 0

enum ObjectTypes {
	Bomb,
	Rasbora,
	Gourami,
	Tetra
}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isPlaying:
		runTime += delta
