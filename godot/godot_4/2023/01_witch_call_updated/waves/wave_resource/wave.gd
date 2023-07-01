class_name Wave extends Resource

@export var time_limit: float = 5
@export var monsterList: Array[WaveMonsterDetails]
@export var min_level: int = 0
@export var max_level: int = 0


func execute_wave() -> void:
	for monster in monsterList:
		SignalBus.spawn_monster_at.emit(monster.monster_scene, monster.lane, monster.delay)
