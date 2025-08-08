extends Node2D

@export var isLeftSpawn: bool = true
@onready var curve: Curve2D = self.get_child(0).curve

func ChangePath(xDist: float, jumpHigh: float):
	
	# you CANNOT just edit the points of the original curve since that edits ALL fish in the scene
	var newCurve: Curve2D = Curve2D.new()
	
	newCurve.add_point(Vector2.ZERO) #current pos
	newCurve.add_point(Vector2(xDist / 2, jumpHigh), Vector2(xDist * -0.75, 0), Vector2(xDist * 0.75, 0)) 
	newCurve.add_point(Vector2(xDist, position.y))
	
	curve = newCurve;
	
	var printLine = ""
	for i in range(0, curve.point_count):
		printLine += str(curve.get_point_position(i)) + ", "
		
	print(printLine)
