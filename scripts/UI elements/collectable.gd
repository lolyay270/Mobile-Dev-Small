extends VSplitContainer

@onready var sprite: TextureRect = $TextureRect
@onready var fishName: Label = $Label
@onready var stats: ObjectStats =  $stats.get_script()

func setStats(res: Resource):
	stats = res
	
	# only if discovered, show full info
	if GameManager.discovered.get(stats.name) == true:
		sprite.texture = stats.sprite
		fishName.text = stats.name
	else:
		sprite.texture = stats.silhouette
		fishName.text = "???"
