extends Label

func _ready() -> void:
	if Global.is_survival:
		text = "Score: " + str(int(round(Global.time)))
	else:
		text = "The winner is: " + ("Red" if Global.died_first == "Blue" else "Blue")
