class_name Wave extends Resource

@export var time_limit: float = 2.5
@export var monster_scene: PackedScene
@export var lanes_to_spawn: Array[int] = [0]


func execute_wave() -> void:
	for lane in lanes_to_spawn:
		SignalBus.spawn_monster_at.emit(monster_scene, lane)
