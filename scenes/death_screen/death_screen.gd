extends Node2D

var count = 0.2

func _process(delta: float) -> void:
	if Input.is_action_just_released("p1_wheel") || Input.is_action_just_released("p2_wheel"):
		count += delta * 10
		$Light.energy = count
	if count > 3:
		get_tree().change_scene_to_file("uid://ca8rew2tw8kkf") # UID Reference to start menu
