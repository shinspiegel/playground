class_name MonsterSpawner extends Node2D

@export var run_data: RunData

func _ready() -> void:
	SignalBus.spawn_monster_at.connect(spawn)


func spawn(monster: PackedScene, lane: int) -> void:
	var monster_instance = monster.instantiate()
	get_parent().add_child(monster_instance)
	monster_instance.global_position.x = get_children()[lane].global_position.x
