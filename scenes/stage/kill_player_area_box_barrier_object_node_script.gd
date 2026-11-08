extends Area2D; 

func _ready() -> void: 
	body_entered.connect((func(b): 
		if b.is_in_group("Player"):
			Global.deaths_this_round += 1;
			if Global.died_first == null:
				Global.died_first = b.name
			b.queue_free()
			if Global.deaths_this_round >= 2 or not Global.is_survival: 
				get_tree().change_scene_to_file.call_deferred("uid://30utcg1gn6of")
				Global.deaths_this_round = 0
			))
