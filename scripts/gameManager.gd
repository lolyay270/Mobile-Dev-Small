extends Node

@export var isPlaying: bool = true
@export var runTime: float = 0 #used for fish spawning
@export var highScore: int = 0

@export var fishResources: Array[Resource] = []
@export var rockResource: Resource

@export var discovered: Dictionary = {}

#signal is equivalent to unity event
signal playStateUpdated

enum ObjectTypes {
	Fish,
	Rock
}


# Get game ready each time the app is loaded
func _ready() -> void:
	SaveData.load_game()
	preloadRequiredAssets()
	
	# create and save discoveries if not exist
	if discovered.is_empty():
		setupObjDiscoveries()
		SaveData.save_game()


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
		"highscore": highScore,
		"discovered": discovered
	}


func preloadRequiredAssets():
	fishResources.append( preload("res://objects/fish types/rasbora.tres"))
	fishResources.append( preload("res://objects/fish types/gourami.tres"))
	fishResources.append( preload("res://objects/fish types/tetra.tres"))
	
	rockResource = preload("res://objects/rock.tres")

func setupObjDiscoveries():
	for obj in fishResources:
		discovered[obj.name] = false
	
	discovered["Rock"] = false
