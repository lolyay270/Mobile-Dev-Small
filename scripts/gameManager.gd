extends Control

var isPlaying: bool = true
var score: int = 0

@onready var scoreDisplay: Label = $"Score"
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


func UpdateScore(change: int):
	score += change
	print("score: ", str(score), scoreDisplay.name)
	#scoreDisplay.set_text( str(score) )
