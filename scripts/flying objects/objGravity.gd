extends PathFollow2D

@export var move: bool = false
@export var speed: int = 700
@export var gravity: float = 2

var curSpeed

func Start() -> void:
	if gravity == 0:
		push_error("gravity should not be 0")
		curSpeed = speed
	
	else:
		#programmatically get a good speed to slow down near the middle, but not stop
		var path: Path2D = self.get_parent()
		var pathLength = path.curve.get_baked_length()
		var half = pathLength / 2
		var frames = half / gravity #frames until 0 speed
		curSpeed = frames * gravity * 0.7 #new max speed so it slows down at a constant since gravity is constant 
	
	move = true


func _process(delta: float) -> void:
	if move:
		if (curSpeed <= 0):
			push_error("TOO MUCH GRAVITY ON FISH")
			curSpeed = 20 #give only a tiny amount of speed to keep them moving
		
		# reduce speed as gravity
		if (progress_ratio < 0.5):
			curSpeed -= gravity
		
		# add speed as gravity
		elif (progress_ratio < 1):
			curSpeed += gravity
		
		# progress_ratio = 1 = complete
		else:
			$"../..".queue_free() #despawn the whole fish object
		
		progress += delta * curSpeed
