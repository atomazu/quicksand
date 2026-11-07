extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_text("Versus")


func _pressed() -> void:
	Global.is_survival = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
