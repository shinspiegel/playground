extends Node

signal health_changed
signal health_zeroed
signal health_maxed

signal power_point_changed(power_points: int, max_power_points: int)

const JUMP_KEY: String = "ui_accept"

const POWERUP_LIST: Array[PlayerPowerUp] = [
	preload("res://entities/player/power_ups/high_jump.tres"),
	preload("res://entities/player/power_ups/power_shot.tres"),
	preload("res://entities/player/power_ups/triple_shot.tres"),
	preload("res://entities/player/power_ups/speed_up.tres"),
]

@export var max_health: int = 20
@export var health: int = 20
@export var max_power_points: int = 50
@export var power_points: int = 0


func _ready() -> void:
	reset_health()
	prepare_power_up_list()
	__calculate_power_usage()


#######################
# Health Related Data #
#######################


func change_health(amount: int) -> void:
	health = clampi(health + amount, 0, max_health)
	health_changed.emit()
	
	if health >= max_health:
		health_maxed.emit()
	
	if health <= 0:
		health_zeroed.emit()


func deal_damage(amount: int) -> void:
	change_health(-amount)


func reset_health() -> void:
	health = max_health


#######################
#  Power Up Related   #
#######################


func prepare_power_up_list() -> void:
	pass
#	for power in POWERUP_LIST:
#		power.selection_change.connect(on_power_up_select.bind(power))


func get_power_up_list() -> Array[PlayerPowerUp]:
	return POWERUP_LIST


func can_add_power_up(power_up: PlayerPowerUp) -> bool:
	return power_points + power_up.cost < max_power_points


func toggle_power_up(power_up: PlayerPowerUp, state: bool) -> void:
	power_up.is_selected = state
	__calculate_power_usage()
	__emit_power_change()


func __calculate_power_usage() -> void:
	power_points = 0
	
	for power in POWERUP_LIST:
		if power.is_selected:
			power_points += power.cost


func __emit_power_change() -> void:
	power_point_changed.emit(power_points, max_power_points)
