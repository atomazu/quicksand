extends RigidBody2D

const SPEED = 300.0
const JUMP_VELOCITY = 400.0

@export var ground_area: Area2D
@export var input_prefix: String

var bodies_below_feet: int
var can_jump: bool = true

func _ready() -> void:
	ground_area.body_entered.connect(_on_ground_area_body_entered)
	ground_area.body_exited.connect(_on_ground_area_body_exited)
	ground_area.area_entered.connect(_on_ground_area_body_entered)
	ground_area.area_exited.connect(_on_ground_area_body_exited)

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed(input_prefix + "_jump") and bodies_below_feet > 1 and can_jump:
		apply_central_impulse(Vector2.UP * JUMP_VELOCITY)
		can_jump = false

	if !Input.is_action_pressed(input_prefix + "_jump"):
		can_jump = true

	var direction := Input.get_axis(input_prefix + "_move_left", input_prefix + "_move_right")
	
	if Input.is_action_just_pressed(input_prefix + "_move_left"):
		apply_central_impulse(Vector2(direction * SPEED, 0))
	
	if Input.is_action_just_pressed(input_prefix + "_move_right"):
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

# Also check for areas so that the quicksand counts as "ground"
# Maybe in future use group for quicksand so othe arears arent confused with ground
func _on_ground_area_area_entered(_body):
	bodies_below_feet += 1

func _on_ground_area_area_exited(_body):
	bodies_below_feet -= 1
