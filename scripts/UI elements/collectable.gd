extends PanelContainer

@onready var sprite: TextureRect = $TextureRect
@onready var fishName: Label = $name
@onready var collectedCounter: Label = $collected
@onready var stats: ObjectStats =  $stats.get_script()

func setStats(res: Resource):
	stats = res
	
	# only if discovered, show full info
	if GameManager.discovered.get(stats.name) > 0:
		sprite.texture = stats.sprite
		fishName.text = stats.name
		collectedCounter.text = str(roundi(GameManager.discovered.get(stats.name))) + " caught"
	else:
		sprite.texture = stats.silhouette
		fishName.text = "???"
		collectedCounter.hide()
