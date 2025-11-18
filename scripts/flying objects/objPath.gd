extends Path2D

func ChangePath(xDist: float, jumpHigh: float):
	
	# set the positions of the 3 points relative to how much space is left on the screen
	curve.set_point_position(0, Vector2(0, position.y))
	
	curve.set_point_position(1, Vector2(xDist / 2, jumpHigh - 720))
	curve.set_point_in(1,  Vector2(xDist / 2 * -0.75, 0))
	curve.set_point_out(1, Vector2(xDist / 2 * 0.75, 0))
	
	curve.set_point_position(2, Vector2(xDist, position.y))
