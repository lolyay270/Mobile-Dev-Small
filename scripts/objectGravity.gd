extends PathFollow2D

@export var move: bool = false
@export var speed: int = 700
@export var gravity: float = 2.4

var curSpeed
var lowestSpeed
var startSpeed

func Start() -> void:
	if gravity == 0:
		push_error("gravity should not be 0")
		curSpeed = speed
		startSpeed = speed
	
	else:
		#programmatically get a good speed to slow down near the middle, but not stop
		var path: Path2D = self.get_parent()
		var pathLength = path.curve.get_baked_length()
		var half = pathLength / 2
		var frames = half / gravity #frames until 0 speed
		startSpeed = frames * gravity * 0.7 #new max speed so it slows down at a constant since gravity is constant 
		curSpeed = startSpeed
		
		#print("path length = " + str(pathLength))
		#print("1/2 length = " + str(half))
		#print("frames until 0 speed = " + str(frames))
		#print("new speed = " + str(newSpeed))
	
	lowestSpeed = curSpeed
	
	move = true


func _process(delta: float) -> void:
	if move:
		if (curSpeed <= 0):
			push_error("TOO MUCH GRAVITY ON FISH")
			curSpeed = speed
		
		if (curSpeed < lowestSpeed):
			lowestSpeed = curSpeed
		
		# reduce speed as gravity
		if (progress_ratio < 0.5):
			curSpeed -= gravity
		
		# add speed as gravity
		elif (progress_ratio < 1):
			curSpeed += gravity
		
	# progress_ratio = 1 = complete
		else:
			#print("fastest = " + str(startSpeed) + "slowest = " + str(lowestSpeed))
			$"../..".queue_free() #despawn the whole fish object
		
		progress += delta * curSpeed
