extends RigidBody2D

var collision_asp: AudioStreamPlayer2D

func _ready() -> void:
	collision_asp = AudioStreamPlayer2D.new()
	add_child(collision_asp)
	collision_asp.stream = preload("uid://d3biya2477t88")
	
	body_entered.connect(_on_body_entered)

func _on_body_entered(body) -> void:
	print(linear_velocity.length())
	if body is RigidBody2D:
		if linear_velocity.length() + body.linear_velocity.length() <= 30.0:
			return
	else:
		if linear_velocity.length() <= 30.0:
			return
	
	collision_asp.play()
