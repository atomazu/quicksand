extends StaticBody2D

@export var SPEED = 1.5

func _physics_process(delta: float) -> void:
	position.y += delta * SPEED
