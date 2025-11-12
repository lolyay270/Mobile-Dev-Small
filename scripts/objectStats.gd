class_name ObjectStats
extends Resource


@export var name: String = "Fish Name Here"
@export var type: GameManager.ObjectTypes = GameManager.ObjectTypes.Fish

# sprites
@export var sprite: CompressedTexture2D = null
@export var silhouette: CompressedTexture2D = null

#score
@export var scoreIncrease: int = 1

#spawn
@export var startSpawnMinutes: float = 0
@export var infiniteSpawns: bool = true
@export var numberOfSpawns: int = 0
@export var isLeftSpawn: bool = true
