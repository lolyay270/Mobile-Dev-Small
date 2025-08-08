extends PathFollow2D

@export var move: bool = false
@export var speed: int = 700
@export var gravity: float = 0

var pathLength
var curSpeed
var lowestSpeed

func _ready() -> void:
	#curSpeed = speed;
	
	
	var path: Path2D = self.get_parent()
	pathLength = path.curve.get_baked_length()
	var half = pathLength / 2
	var frames = half / gravity
	var newSpeed = frames * 1.9
	
	
	
	#print("path length = " + str(pathLength))
	#print("1/2 length = " + str(half))
	#print("frames until 0 speed = " + str(frames))
	#print("new speed = " + str(newSpeed))
	
	curSpeed = speed
	lowestSpeed = curSpeed
	
	

func _process(delta: float) -> void:
	if (curSpeed <= 0):
		push_error("TOO MUCH GRAVITY ON FISH")
	
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
		#print("lowest speed = " + str(lowestSpeed))
		self.queue_free()
	
	progress += delta * curSpeed
