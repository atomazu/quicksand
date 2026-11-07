extends Node2D

var time = 0.0

func _process(delta: float) -> void:
	time += delta
	Global.time = time
	$Timer.text = str(int(time))
