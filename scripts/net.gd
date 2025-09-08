extends Sprite2D


func _on_area_entered(area: Area2D) -> void:
	NetObject(area)


func NetObject(area: Area2D):
	var object: Node2D = area.get_parent().get_parent().get_parent()  #get pathFollow, then path, then parent node
	var objType: GameManager.ObjectTypes = object.type
	
	if objType == GameManager.ObjectTypes.Bomb:
		GameManager.UpdateHealth(-1)
	else:
		GameManager.UpdateScore(1)
		
	object.queue_free()
