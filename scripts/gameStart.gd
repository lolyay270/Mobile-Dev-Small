"""
This script resets GameManager (a singleton) to its default values
when a new run of the game begins 

And hold values for the UI elements to adapt to different screen sizes
"""

extends Node

@onready var viewportSize: Vector2i = get_viewport().size
var largestAxis: int

var edgeScreenPaddingPerc: float = 0.03 #percent of edge of screen not covered UI elements
@export var edgeScreenPaddingPx: float = 0

var betweenUIPaddingPerc: float = 0.01
@export var betweenUIPaddingPx: float = 0

@export var newCollected: Array[Resource] = []


func _ready() -> void:
	largestAxis = max(viewportSize.x, viewportSize.y)
	edgeScreenPaddingPx = largestAxis * edgeScreenPaddingPerc
	betweenUIPaddingPx = largestAxis * betweenUIPaddingPerc
	
	GameManager.ResetToDefault()
	
