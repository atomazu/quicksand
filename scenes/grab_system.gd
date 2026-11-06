extends Node

@export var raycast: RayCast2D
@export var grabpoint: Node2D

@onready var input_prefix = get_parent().input_prefix

var current_collider: RigidBody2D
var last_collider: RigidBody2D

func _input(event: InputEvent) -> void:
	var direction := Input.get_axis(input_prefix + "_move_left", input_prefix + "_move_right")
	if direction != 0:
		raycast.target_position = raycast.target_position * Vector2(-1, 1)
		grabpoint.position = grabpoint.position * Vector2(-1, 1)
	
	if event.is_action_pressed(input_prefix + "_interact1"):
		print("INTERACT PRESSED FOR " + input_prefix)
		if raycast.get_collider() is RigidBody2D:
			current_collider = raycast.get_collider()
			current_collider.modulate = Color8(255, 255, 255, 100)

func _physics_process(_delta: float) -> void:
	if current_collider:
		current_collider.global_position = grabpoint.global_position

func release_collider() -> void:
	if !current_collider:
		return
	
	last_collider = current_collider
	last_collider.modulate = Color.WHITE
	current_collider = null
