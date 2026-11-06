extends RigidBody2D

const SPEED = 300.0
const JUMP_VELOCITY = 400.0

@export var ground_area: Area2D
@export var action_move_left: String
@export var action_move_right: String
@export var action_jump: String

var bodies_below_feet: int
var temp: bool = true

func _ready() -> void:
	ground_area.body_entered.connect(_on_ground_area_body_entered)
	ground_area.body_exited.connect(_on_ground_area_body_exited)

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed(action_jump) and bodies_below_feet > 1 and temp:
		apply_central_impulse(Vector2.UP * JUMP_VELOCITY)
		temp = false

	if !Input.is_action_pressed(action_jump):
		temp = true

	var direction := Input.get_axis(action_move_left, action_move_right)
	
	if Input.is_action_just_pressed(action_move_left):
		apply_central_impulse(Vector2(direction * SPEED, 0))
	
	if Input.is_action_just_pressed(action_move_right):
		apply_central_impulse(Vector2(direction * SPEED, 0))
	
	apply_central_force(Vector2(direction * SPEED, 0))
	
	if abs(linear_velocity.x) > SPEED:
		apply_central_force(Vector2(-direction * SPEED, 0))
	
	if direction == 0.0:
		apply_central_impulse(Vector2(-linear_velocity.x, 0)/8)

func _on_ground_area_body_entered(_body):
	bodies_below_feet += 1

func _on_ground_area_body_exited(_body):
	bodies_below_feet -= 1
