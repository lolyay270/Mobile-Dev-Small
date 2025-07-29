extends RigidBody2D

@export var spawnLeft: bool # fish spawns on left half to jump to the right
@export var horDistance: float
@export var vertDistance: float

func _ready() -> void:
	if (!spawnLeft):
		horDistance *= -1
	apply_central_impulse(Vector2(horDistance,vertDistance * -1))

func _process(delta: float) -> void:
	pass
	# rotate based on screen position - set_angular_velicity(speed: float)
	# 

func _physics_process(delta: float) -> void:
	look_at(linear_velocity + position)
	
