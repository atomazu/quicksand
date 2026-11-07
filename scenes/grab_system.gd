extends Node

@export var raycast: RayCast2D
@export var grabpoint: Node2D
@export var pinjoin: PinJoint2D

@onready var input_prefix = get_parent().input_prefix
@onready var start_grab_dir: float = abs(grabpoint.position.x)
@onready var start_raycast_target: float = abs(raycast.target_position.x)

var current_collider: RigidBody2D
var last_collider: RigidBody2D

func _input(event: InputEvent) -> void:
	var direction := Input.get_axis(input_prefix + "_move_left", input_prefix + "_move_right")
	if direction != 0.0:
		raycast.target_position.x = start_raycast_target * sign(direction)
		grabpoint.position.x = start_grab_dir * sign(direction)
	
	if event.is_action_pressed(input_prefix + "_interact1"):
		print("INTERACT PRESSED FOR " + input_prefix)
		release_collider()
		if raycast.get_collider() is RigidBody2D:
			current_collider = raycast.get_collider()
			current_collider.modulate = Color8(255, 255, 255, 200)

func _physics_process(_delta: float) -> void:
	if current_collider:
		var dir = (grabpoint.global_position - current_collider.global_position).normalized()
		current_collider.apply_central_force(dir * 5000.0)

func release_collider() -> void:
	if !current_collider:
		return
	
	#pinjoin.node_b = get_parent().get_path()
	last_collider = current_collider
	last_collider.modulate = Color.WHITE
	current_collider = null
