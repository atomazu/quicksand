extends Node

@export var spawn_container: Node2D
@export var spawn_height: float
@export var spawn_width: float
@export var entity_list: EntityList

var time = 1.0

func _ready() -> void:
	for i in range(10):
		await get_tree().create_timer(0.2).timeout
		start()

func _process(delta: float) -> void:
	time += delta / 3

func start() -> void:
	while true:
		for entity in entity_list.entities:
			# TODO play with optimal randomized spawn timer
			await get_tree().create_timer(randi_range(2 + sqrt(time),  3 + sqrt(time))).timeout
			var instance: Node2D = entity.scene.instantiate()
			var size = Vector2.ONE*randi_range(1, 3)
			# TODO perhaps add floating scaling
			# TODO add that size scales smaller over time
			instance.get_child(0).get_child(0).scale = size
			instance.get_child(0).get_child(1).scale = size
			spawn_container.add_child.call_deferred(instance)
			instance.global_position = Vector2(randf_range(-spawn_width, spawn_width), spawn_height)
