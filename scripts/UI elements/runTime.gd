"""
This script manages the display of the run time in game
Both postion and value
"""

extends Label

@onready var gameStart: Node = $"/root/Game"
@onready var scoreDisplay: Label = $"/root/Game/Score"
@onready var timeBG: ColorRect = $bg

func _ready() -> void:
	await get_tree().process_frame #wait for gameStart to calc values
	
	var selfSize = (timeBG.size.x * timeBG.scale.x)
	var scoreSize = (scoreDisplay.scoreBG.size.x * scoreDisplay.scoreBG.scale.x)
	var xPos = gameStart.viewportSize.x - selfSize - scoreSize - gameStart.edgeScreenPaddingPx - gameStart.betweenUIPaddingPx
	
	var yPos = gameStart.edgeScreenPaddingPx
	self.global_position = Vector2(xPos, yPos)

func _process(delta: float) -> void:
	if (GameManager.isPlaying):
		self.text = GameManager.humanReadableRunTime()
