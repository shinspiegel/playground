class_name PlayerData extends Resource

@export var max_hit_points: int = 5
@export var hit_points: int = 5: set = set_hit_points


func hurt(amount: int) -> void:
	set_hit_points(-amount)


func heal(amount: int) -> void:
	set_hit_points(amount)


func set_hit_points(val: int) -> void:
	if val + hit_points <= 0:
		hit_points = 0
	
	elif hit_points + val >= max_hit_points:
		hit_points = max_hit_points
	
	else: 
		hit_points += val
	
	SignalBus.player_hp_changed.emit(hit_points, max_hit_points)

func reset() -> void:
	max_hit_points = 5
	hit_points = 5
