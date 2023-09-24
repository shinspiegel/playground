extends Node

const JUMP_KEY: String = "ui_accept"
const POWERUP_LIST: Array[PlayerPowerUp] = [
	preload("res://entities/player/power_ups/high_jump.tres"),
	preload("res://entities/player/power_ups/power_shot.tres"),
	preload("res://entities/player/power_ups/triple_shot.tres"),
	preload("res://entities/player/power_ups/speed_up.tres"),
]

signal health_changed
signal health_zeroed
signal health_maxed

@export var max_health: int = 20
@export var health: int = 20
@export var selected_power_ups: Array[PlayerPowerUp] = []


func _ready() -> void:
	reset_health()

# Health Related Data

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


# Power Up Related data

func get_power_up_list() -> Array[PlayerPowerUp]:
	return POWERUP_LIST
