extends VSplitContainer

@onready var sprite: TextureRect = $TextureRect
@onready var fishName: Label = $Label
@onready var stats: ObjectStats =  $stats.get_script()

func setStats(res: Resource):
	stats = res
	
	#change sprite to match stats
	sprite.texture = stats.sprite
	fishName.text = stats.name
