extends Node

@onready var anim: AnimationPlayer = $animations/AnimationPlayer

@onready var fishVisuals: Array = [$animations/Score, $info/MarginContainer/fishCollectText]
@onready var rockVisuals: Array = [$animations/healths, $info/MarginContainer/rockCollectText]

@onready var collectee: TextureRect = $animations/collectee
@onready var valueChange: Label = $"animations/points change"
@onready var nextButton: Button = $Button

#keep track of which step is animating
var isPlayingFishAnim: bool = true



func _onready() -> void:
	anim.play("collectItem")
	collectee.texture = GameManager.fishResources[0].sprite


func _on_button_up() -> void:
	anim.stop()
	
	# currently playing fishCollect, change to rockCollect
	if isPlayingFishAnim:
		for obj in fishVisuals:
			obj.hide()
		for obj in rockVisuals:
			obj.show()
		
		collectee.texture = GameManager.rockResource.sprite
		valueChange.text = "-1"
		nextButton.text = "BACK"
		
		isPlayingFishAnim = false
	
	# currently playing rockCollect, change to fishCollect
	else:
		for obj in rockVisuals:
			obj.hide()
		for obj in fishVisuals:
			obj.show()
		
		collectee.texture = GameManager.fishResources[0].sprite
		valueChange.text = "+1"
		nextButton.text = "NEXT"
		
		isPlayingFishAnim = true
	
	anim.play("collectItem")
