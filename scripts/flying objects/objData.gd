extends Node2D

@onready var stats: ObjectStats = $Stats.get_script()
@onready var sprite: Sprite2D = $Path2D/PathFollow2D/Sprite2D

func setStats(script: Resource):
	stats = script
	
	#update sprite
	sprite.texture = stats.sprite
