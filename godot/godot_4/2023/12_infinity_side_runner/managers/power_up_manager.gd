extends Node

const POWERUP_LIST: Array[PlayerPowerUp] = [
	preload("res://entities/player/power_ups/high_jump.tres"),
	preload("res://entities/player/power_ups/power_shot.tres"),
	preload("res://entities/player/power_ups/triple_shot.tres"),
	preload("res://entities/player/power_ups/speed_up.tres"),
]


func _ready() -> void:
	for power in POWERUP_LIST:
		power.selection_change.connect(on_power_up_select.bind(power))



func get_list() -> Array[PlayerPowerUp]:
	return POWERUP_LIST


func on_power_up_select(state: bool, powerUp: PlayerPowerUp) -> void:
	print("[%s]::[%s]" % [state, powerUp])
	pass
