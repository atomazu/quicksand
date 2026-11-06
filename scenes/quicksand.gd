extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if (body is RigidBody2D):
		body.linear_velocity = Vector2.ZERO
		body.gravity_scale = 0.05


func _on_body_exited(body: Node2D) -> void:
	if (body is RigidBody2D):
		body.gravity_scale = 1
