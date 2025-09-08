extends Node

@export var health: int
var maxHealth = 3

@onready var display: Node = $"Display"
@onready var endScene: PackedScene = preload("res://scenes/gameOver.tscn")

func _ready() -> void:
	health = maxHealth

func UpdateHealth(change: int):
	if health > 0:
		health += change
		display.UpdateDisplay()
