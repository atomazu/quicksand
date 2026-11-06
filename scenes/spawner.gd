extends Node

@export var spawn_container: Node2D
@export var entities: Array[Entity]
@export var spawn_height: float
@export var spawn_width: float

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	start()

func start() -> void:
	for entity in entities:
		var instance: Node2D = entity.scene.instantiate()
		spawn_container.add_child.call_deferred(instance)
		instance.global_position = Vector2(randf_range(-spawn_width, spawn_width), spawn_height)
