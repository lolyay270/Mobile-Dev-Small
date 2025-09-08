extends Node

var hearts: Array[Node]
@onready var heartSprite: CompressedTexture2D = preload("res://icon.svg")

@onready var viewportSize = get_viewport().size
var betweenHeartPadding = 0.01
var edgeScreenPaddingPerc = 0.03 #percent of edge of screen not covered by hearts
var edgeScreenPaddingPx




func _ready() -> void:
	edgeScreenPaddingPx = max(viewportSize.x, viewportSize.y) * edgeScreenPaddingPerc
	
	GameManager.healthUpdated.connect(UpdateDisplay)
	SpawnHearts(GameManager.maxHealth)


func SpawnHearts(count: int):
	for i in count:
		var heart = Sprite2D.new()
		self.add_child(heart)
		hearts.append(heart)
		heart.texture = heartSprite
		
		heart.offset = Vector2(heartSprite.get_width() * 0.5, heartSprite.get_height() * 0.5)
		var xPos: int = viewportSize.x - heartSprite.get_width() * (i + 1) - edgeScreenPaddingPx - viewportSize.x * betweenHeartPadding * i
		var yPos: int = edgeScreenPaddingPx
		heart.global_position = Vector2(xPos, yPos)


func UpdateDisplay():
	print(GameManager.health)
	for heart in hearts:
		if hearts.find(heart) > GameManager.health:
			heart.queue_free()
