extends Node

@export var raycast: RayCast2D
@export var grabpoint: Node2D
#@export var lightcone: PointLight2D
@export var sprite: Sprite2D

@onready var input_prefix = get_parent().input_prefix
@onready var start_grab_dir: float = abs(grabpoint.position.x)
@onready var start_raycast_target: float = abs(raycast.target_position.x)
#@onready var lightcone_start_size: float = lightcone.scale.x

var current_collider: RigidBody2D
var last_collider: RigidBody2D
var remove_outline: Array[Sprite2D]

func _input(event: InputEvent) -> void:
	var direction := Input.get_axis(input_prefix + "_move_left", input_prefix + "_move_right")
	if direction != 0.0:
		raycast.target_position.x = start_raycast_target * sign(direction)
		grabpoint.position.x = start_grab_dir * sign(direction)
		if direction < 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		#lightcone.scale.x = lightcone_start_size * sign(direction)
	
	if event.is_action_pressed(input_prefix + "_interact1"):
		if current_collider:
			release_collider()
			return
		print("INTERACT: " + input_prefix + " did it")
		if raycast.get_collider() is RigidBody2D:
			if raycast.get_collider().is_in_group("Player"): 
				print("INTERACT: Can't grab player")
				return
			current_collider = raycast.get_collider()
			if get_parent().get_collision_layer_value(2):
				current_collider.set_collision_layer_value(2,false)
				current_collider.set_collision_mask_value(2,false)
			elif get_parent().get_collision_layer_value(3):
				current_collider.set_collision_layer_value(3,false)
				current_collider.set_collision_mask_value(3,false)
			current_collider.modulate = Color8(255, 255, 255, 200)

func _physics_process(_delta: float) -> void:
	if current_collider:
		var dir = (grabpoint.global_position - current_collider.global_position).normalized()
		current_collider.apply_central_force(dir * 5000.0)
	
	if raycast.get_collider() is RigidBody2D and raycast.get_collider().is_in_group("Player"): return
	
	while remove_outline.size() > 0:
		var sprite: Sprite2D = remove_outline.pop_back()
		sprite.material = null
	
	if raycast.get_collider() or current_collider:
		var obj = current_collider if current_collider else raycast.get_collider()
		var sprite: Sprite2D = obj.get_node("Sprite2D")
		if not sprite: return
		var mat := ShaderMaterial.new() 
		mat.shader = preload("uid://d24ctoml41xv2")
		sprite.material = mat
		remove_outline.append(sprite)

func release_collider() -> void:
	if !current_collider:
		return
	
	last_collider = current_collider
	last_collider.modulate = Color.WHITE
	last_collider.set_collision_layer_value(2,true)
	last_collider.set_collision_layer_value(3,true)
	last_collider.set_collision_mask_value(2,true)
	last_collider.set_collision_mask_value(3,true)
	current_collider = null
