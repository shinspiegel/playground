class_name MonsterSpawner extends Node2D

@export var run_data: RunData

@onready var monsters: Node2D = $Enemies
@onready var markers: Node2D = $Markers


func _ready() -> void:
	SignalBus.spawn_monster_at.connect(spawn)
	SignalBus.clean_all_monster.connect(reset_monsters)


func spawn(monster: PackedScene, lane: int, delay: float = 0.0) -> void:
	if delay > 0.0:
		var timer = Timer.new()
		add_child(timer)
		timer.start(delay)
		timer.timeout.connect(func(): 
			instanciate_monster(monster, lane)
			timer.queue_free()
		)
	else:
		instanciate_monster(monster, lane)


func instanciate_monster(monster: PackedScene, lane: int) -> void:
	var monster_instance: MonsterBase = monster.instantiate()
	monster_instance.hit_points += get_level_hp_boost()
	monsters.add_child(monster_instance)
	monster_instance.global_position.x = get_mosnter_position_by_lane(lane)


func get_level_hp_boost() -> int:
	return int(run_data.level / 10)


func reset_monsters() -> void:
	for enemy in monsters.get_children():
		enemy.queue_free()


func get_mosnter_position_by_lane(lane: int) -> float:
	return markers.get_children()[lane].global_position.x
