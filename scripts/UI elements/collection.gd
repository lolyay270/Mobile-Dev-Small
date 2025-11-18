extends GridContainer

@onready var collectablePrefab: PackedScene = preload("res://objects/collectable.tscn")

var collectables: Array

func _ready() -> void:
	GameManager.setupObjDiscoveries()
	
	# get all objects to show, ensure rock is last
	collectables.append_array(GameManager.fishResources)
	collectables.append(GameManager.rockResource)
	
	# adjust columns to fit the number of fish
	# this will only look good until 10 objects, 11 looks BAD
	self.columns = ceil(collectables.size() / 2.0)
	
	# add each object into the scene
	for object in collectables:
		var collect = collectablePrefab.instantiate()
		add_child(collect)
		
		collect.setStats(object)
		
