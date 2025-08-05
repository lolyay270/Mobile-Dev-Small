extends PathFollow2D

@export var move: bool = false
@export var speed: int = 700
@export var gravity: float = 3
var curSpeed;

func _ready() -> void:
	curSpeed = speed;

func _process(delta: float) -> void:
	# reduce speed as gravity
	if (progress_ratio < 0.5):
		curSpeed -= gravity
	
	# add speed as gravity
	elif (progress_ratio < 1):
		curSpeed += gravity
	
	# progress_ratio = 1 = complete
	else:
		self.queue_free()
	
	progress += delta * curSpeed
