extends Node

@export var spawn_container: Node2D
@export var spawn_height: float
@export var spawn_width: float
@export var entity_list: EntityList

func _ready() -> void:
	for i in range(10):
		await get_tree().create_timer(0.1).timeout
		start()

func start() -> void:
	for entity in entity_list.entities:
		# TODO play with optimal randomized spawn timer
		await get_tree().create_timer(randi_range(1, 10)).timeout
		var instance: Node2D = entity.scene.instantiate()
		var size = Vector2.ONE*randi_range(1, 3)
		instance.get_child(0).get_child(0).scale = size
		instance.get_child(0).get_child(1).scale = size
		spawn_container.add_child.call_deferred(instance)
		instance.global_position = Vector2(randf_range(-spawn_width, spawn_width), spawn_height)
