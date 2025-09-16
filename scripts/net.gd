extends Sprite2D

@onready var healthManager = $"/root/Game/Health"
@onready var scoreManager = $"/root/Game/Score"


func _on_area_entered(area: Area2D) -> void:
	NetObject(area)


func NetObject(area: Area2D):
	var object: Node2D = area.get_parent().get_parent().get_parent()  #get pathFollow, then path, then parent node
	var objType: GameManager.ObjectTypes = object.type
	
	if objType == GameManager.ObjectTypes.Bomb:
		healthManager.UpdateHealth(-1)
	else:
		scoreManager.UpdateScore(1)
		
	object.queue_free()
