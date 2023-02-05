class_name MonsterSpawner extends Node2D

@export var run_data: RunData

func _ready() -> void:
	SignalBus.spawn_monster_at.connect(spawn)


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
	var monster_instance = monster.instantiate()
	get_parent().add_child(monster_instance)
	monster_instance.global_position.x = get_children()[lane].global_position.x
