extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while true:
		set_title()
		await get_tree().create_timer(randi_range(3, 13)).timeout
	pass # Replace with function body.

func set_title() -> void:
	var title = first_adjectiv.pick_random() + " " + middle_noun. pick_random() + " " + last_adjectiv.pick_random()
	set_text(title)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

var first_adjectiv = ["", "Quick", "Fast", "Schnell", "Sturmiger", "Sandiger", "Rocky", "Coarse", "Clean", "Defenitly", "Dirty", "Ofcourse"]
var middle_noun = ["Sand", "Sandsturm"]
var last_adjectiv = ["", "Quick", "Fast", "Schnell", "Sturmiger", "Sandiger", "Rocky", "Coarse", "Clean", "Defenitly", "Dirty", "Ofcourse"]
