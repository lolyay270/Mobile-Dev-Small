extends Control

@onready var healthManager = $".."
@onready var scoreBG = $"../../Score/bg"
@onready var gameStart = $"/root/Game"

var hearts: Array[Node]
@onready var heartSprite: CompressedTexture2D = preload("res://icon.svg")


func _ready() -> void:
	await get_tree().process_frame #wait for gameStart to calc values
	SpawnHearts(healthManager.maxHealth)


func SpawnHearts(count: int):
	for i in count:
		#create heart object and add sprite
		var heart = Sprite2D.new()
		self.add_child(heart)
		hearts.append(heart)
		heart.texture = heartSprite
		
		#centre the pivot in the images
		heart.offset = Vector2(heartSprite.get_width() * 0.5, heartSprite.get_height() * 0.5)
		
		#move each heart further from the right wall
		var xPos: int = gameStart.viewportSize.x - heartSprite.get_width() * (i + 1) - gameStart.edgeScreenPaddingPx - gameStart.betweenUIPaddingPx * i
		
		#move the hearts all below the score bar
		var yPos: int = gameStart.edgeScreenPaddingPx + (gameStart.betweenUIPaddingPx * 2) + (scoreBG.size.y * scoreBG.scale.y)
		
		heart.global_position = Vector2(xPos, yPos)


func UpdateDisplay():
	var lostHeart = hearts[healthManager.health]
	lostHeart.queue_free()
	hearts.erase(lostHeart)
