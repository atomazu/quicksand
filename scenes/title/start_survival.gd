extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_text("Survival")
	grab_focus()


func _pressed() -> void:
	Global.is_survival = true
	get_tree().change_scene_to_file("uid://d4fk12lnxrekv") # UID Ref to Stage
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
