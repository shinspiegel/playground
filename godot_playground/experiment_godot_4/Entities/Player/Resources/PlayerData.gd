class_name PlayerData extends Resource

@export var max_hit_points: int = 5
@export var hit_points: int = 5: set = set_hit_points


func set_hit_points(val: int) -> void:
	if val + hit_points <= 0:
		SignalBus.player_hp_changed.emit(0)
		hit_points = 0
	
	elif hit_points + val >= max_hit_points:
		SignalBus.player_hp_changed.emit(max_hit_points)
		hit_points = max_hit_points
	
	else: 
		hit_points = val
