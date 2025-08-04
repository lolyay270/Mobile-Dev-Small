extends RigidBody2D

@export var spawnLeft: bool # fish spawns on left half to jump to the right
@export var horDistance: float
@export var vertDistance: float
@export var ySpawnPos: float

@onready var sprite: Sprite2D = $Sprite2D

func _process(delta: float) -> void:
	if global_position.y > ySpawnPos + 100:
		self.queue_free()

# only start moving the fish when spawner gives values
func Start():
	if (!spawnLeft):
		sprite.flip_v = true
	
	gravity_scale = 1 # start gravity 
	
	if (!spawnLeft):
		horDistance *= -1
	
	apply_central_impulse(Vector2(horDistance / 2.8, vertDistance * -2))

func _physics_process(delta: float) -> void:
	look_at(linear_velocity + position)
	
