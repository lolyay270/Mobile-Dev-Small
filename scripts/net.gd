"""
This script manages the trigger area and visuals of the net object
"""

extends Sprite2D

#external scripts
@onready var gameStart: Node = $"/root/Game"
@onready var healthManager = $"/root/Game/Health"
@onready var scoreManager = $"/root/Game/Score/Value"

# related to net
@onready var trigger = $Area2D/CollisionPolygon2D
@onready var touch = $".."


func _on_area_entered(area: Area2D) -> void:
	#only check and destroy obj if net moving upwards
	if touch.canCatch: 
		#get pathFollow, then path, then object's parent node
		var object: Node2D = area.get_parent().get_parent().get_parent()
		
		if object.stats.type == GameManager.ObjectTypes.Rock:
			healthManager.UpdateHealth(-1)
		else:
			scoreManager.UpdateScore(object.stats.scoreIncrease)
		
		# save that the obj has been collected
		var currCount: int = GameManager.discovered.get(object.stats.name)
		if currCount == 0:
			gameStart.newCollected.append(object.stats)
		GameManager.discovered.set(object.stats.name, currCount + 1)
		
		SaveData.save_game()
		
		object.queue_free()


func ChangeStatus(value: bool):
	self.set_visible(value) #toggle vision
	trigger.set_disabled(!value) #toggle collider
