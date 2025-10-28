extends Label

@onready var gameStart: Node = $"/root/Game"
@onready var scoreBG: ColorRect = $bg

func _ready() -> void:
	await get_tree().process_frame #wait for gameStart to calc values
	PositionScore()
	
func PositionScore():
	# move score away from right and top walls
	var xPos = gameStart.viewportSize.x - gameStart.edgeScreenPaddingPx - (scoreBG.size.x * scoreBG.scale.x)
	var yPos = gameStart.edgeScreenPaddingPx
	self.global_position = Vector2(xPos, yPos)
