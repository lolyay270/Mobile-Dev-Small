"""
This script manages the trigger area and visuals of the net object
"""

extends Sprite2D

#external scripts
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
		var objType: GameManager.ObjectTypes = object.type
		
		if objType == GameManager.ObjectTypes.Rock:
			healthManager.UpdateHealth(-1)
		else:
			scoreManager.UpdateScore(1)
		
		object.queue_free()


func ChangeStatus(value: bool):
	self.set_visible(value) #toggle vision
	trigger.set_disabled(!value) #toggle collider
