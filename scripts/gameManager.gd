extends Node

@export var isPlaying: bool = true
@export var runTime: float = 0 #used for fish spawning
@export var highScore: int = 0

@export var fishResources: Array[Resource] = []
@export var rockResource: Resource

#signal is equivalent to unity event
signal playStateUpdated

enum ObjectTypes {
	Fish,
	Rock
}


# Load save data each time the game is run
func _ready() -> void:
	SaveData.load_game()
	
	preloadRequiredAssets()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	runTime += delta


func UpdatePlayState(value: bool):
	isPlaying = value
	playStateUpdated.emit()


func ResetToDefault():
	UpdatePlayState(true)
	runTime = 0


# func for SaveData to call when saving to file
func save():
	return {
		"highscore": highScore
	}


func preloadRequiredAssets():
	fishResources.append( preload("res://objects/fish types/rasbora.tres"))
	fishResources.append( preload("res://objects/fish types/gourami.tres"))
	fishResources.append( preload("res://objects/fish types/tetra.tres"))
	
	rockResource = preload("res://objects/rock.tres")
