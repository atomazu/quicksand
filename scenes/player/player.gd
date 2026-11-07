extends RigidBody2D

const SPEED = 300.0
const JUMP_VELOCITY = 400.0

@export var ground_area: Area2D
@export var input_prefix: String

@onready var timer := Timer.new()

var bodies_below_feet: int
var can_jump: bool = true
var in_sand: bool = false
var sand_damp = 1

func _ready() -> void:
	ground_area.body_entered.connect(_on_ground_area_body_entered)
	ground_area.body_exited.connect(_on_ground_area_body_exited)
	ground_area.area_entered.connect(_on_ground_area_area_entered)
	ground_area.area_exited.connect(_on_ground_area_area_exited)
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed(input_prefix + "_jump") and bodies_below_feet > 1 and can_jump:
		apply_central_impulse(Vector2.UP * JUMP_VELOCITY * sand_damp)
		can_jump = false

	if !Input.is_action_pressed(input_prefix + "_jump"):
		can_jump = true

	var direction := Input.get_axis(input_prefix + "_move_left", input_prefix + "_move_right")
	
	if Input.is_action_just_pressed(input_prefix + "_move_left"):
		apply_central_impulse(Vector2(direction * SPEED * sand_damp, 0))
	
	if Input.is_action_just_pressed(input_prefix + "_move_right"):
		apply_central_impulse(Vector2(direction * SPEED * sand_damp, 0))
	
	apply_central_force(Vector2(direction * SPEED, 0))
	
	if abs(linear_velocity.x) > SPEED:
		apply_central_force(Vector2(-direction * SPEED, 0))
	
	if direction == 0.0:
		apply_central_impulse(Vector2(-linear_velocity.x, 0)/8)

func _on_ground_area_body_entered(_body: Node):
	bodies_below_feet += 1
	if !timer.is_stopped() and !_body.is_in_group("Player") and !_body is TileMapLayer and !in_sand:
		timer.stop()
		sand_damp = 1

func _on_ground_area_body_exited(_body):
	bodies_below_feet -= 1

func _on_ground_area_area_entered(_body):
	bodies_below_feet += 1
	in_sand = true
	if timer.is_stopped():
		timer.start(1)

func _on_ground_area_area_exited(_body):
	bodies_below_feet -= 1
	in_sand = false

# TODO: Show who has won in results screen in versus mode
# INVESTIGATE: Sometimes it does not progress to death scene... for some reason
func _on_timer_timeout():
	if sand_damp == 0:
		Global.deaths_this_round += 1
		# Called when: A player has died
		# Versus => Exit to results screen
		# Survival => If `Global.deaths_this_round` count is at least 2, exit to results screen
		if ((not Global.is_survival) or (Global.deaths_this_round >= 2)): 
			Global.winner = name
			get_tree().change_scene_to_file("uid://30utcg1gn6of") # UID Reference to death screen
			Global.deaths_this_round = 0
	elif sand_damp < 0.15:
		sand_damp = 0
	else:
		sand_damp *= 0.6
