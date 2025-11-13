extends GridContainer

@onready var collectablePrefab: PackedScene = preload("res://objects/collectable.tscn")

func _ready() -> void:
	var collect = collectablePrefab.instantiate()
	collect.stat
