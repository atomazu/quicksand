extends Node

@export var spawn_container: Node2D
@export var spawn_height: float
@export var spawn_width: float
@export var entity_list: EntityList
var time := 0.0
func _ready() -> void:
	for i in range(5):
		await get_tree().create_timer(0.2).timeout
		start()

func _process(delta: float) -> void:
	time += delta / 3

func start() -> void:
	while true:
		for entity in entity_list.entities:
			@warning_ignore("narrowing_conversion")
			await get_tree().create_timer(randi_range(2 + sqrt(time),  3 + sqrt(time))).timeout
			var instance: Node2D = entity.scene.instantiate()
			var size = Vector2.ONE
			@warning_ignore("narrowing_conversion")
			size = size * (0.1 * randi_range(20.0 / (1 + sqrt(time*0.01)), 30.0 / 1 + (sqrt(time*0.01))))
			instance.get_child(0).get_child(0).scale = size
			instance.get_child(0).get_child(1).scale = size
			spawn_container.add_child.call_deferred(instance)
			instance.global_position = Vector2(randf_range(-spawn_width, spawn_width), spawn_height)
