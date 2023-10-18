extends Node

signal health_changed
signal health_zeroed
signal health_maxed

signal power_point_changed(power_points: int, max_power_points: int)

const JUMP_KEY: String = "ui_accept"
const SPEED: float = 6.0
const JUMP_VELOCITY: float = 12.0
const DEFAULT_EXTRA_RATIO: float = 1.0
const INITIAL_POWER_POINT: int = 0
const INITIAL_MAX_HEALTH: int = 20
const INITIAL_ARMOR: int = 0

const POWERUP_LIST: Array[PlayerPowerUp] = [
	# Offensive 
	preload("res://entities/player/power_ups/offensive/neon_crossbow.tres"), 
	preload("res://entities/player/power_ups/offensive/dark_shooter.tres"), 
	preload("res://entities/player/power_ups/offensive/gear_cannon.tres"),
	
	# Defensive
	preload("res://entities/player/power_ups/defensive/extra_health.tres"),
	preload("res://entities/player/power_ups/defensive/health_regen.tres"),
	preload("res://entities/player/power_ups/defensive/armor_plating.tres"),
]

@export var max_health: int = INITIAL_MAX_HEALTH
@export var health: int = INITIAL_MAX_HEALTH
@export var armor: int = 0
@export var max_power_points: int = 5
@export var power_points: int = 0
@export var damage_colddown: float = 0.3

var __extra_jump_power: float = DEFAULT_EXTRA_RATIO
var __extra_speed: float = DEFAULT_EXTRA_RATIO


func _ready() -> void:
	reset_health()
	__calculate_power_usage()


#######################
# Health Related Data #
#######################

func change_health(amount: int) -> PlayerData:
	health = clampi(health + amount, 0, max_health)
	health_changed.emit()
	
	if health >= max_health:
		health_maxed.emit()
	
	if health <= 0:
		health_zeroed.emit()
	
	return self


func apply_armor_to_damage(damage:Damage) -> Damage:
	damage.amount = clampi(damage.amount - armor, 0, damage.amount)
	return damage


func heal_damage(amount: int) -> PlayerData:
	change_health(amount)
	return self


func deal_damage(amount: int) -> PlayerData:
	change_health(-amount)
	return self


func reset_health() -> PlayerData:
	health = max_health
	return self


func get_player_jump_velocity() -> float:
	return JUMP_VELOCITY * GameManager.MULTIPLIER * __extra_jump_power * -1


func get_horizontal_speed(delta: float = 1.0) -> float:
	return SPEED * GameManager.MULTIPLIER * __extra_speed * delta


#######################
#  Power Up Related   #
#######################

func get_power_up_list() -> Array[PlayerPowerUp]:
	return POWERUP_LIST


func can_add_power_up(power_up: PlayerPowerUp) -> bool:
	return power_points + power_up.cost < max_power_points


func toggle_power_up(power_up: PlayerPowerUp, state: bool) -> void:
	power_up.is_selected = state
	__calculate_power_usage()
	__emit_power_change()


func __calculate_power_usage() -> void:
	max_health = INITIAL_MAX_HEALTH
	power_points = INITIAL_POWER_POINT
	armor = INITIAL_ARMOR
	__extra_jump_power = DEFAULT_EXTRA_RATIO
	__extra_speed = DEFAULT_EXTRA_RATIO
	
	for power in POWERUP_LIST:
		if power.is_selected:
			power_points += power.cost
			__extra_jump_power += power.extra_jump_power
			__extra_speed += power.extra_speed
			max_health += power.extra_health
			armor += power.extra_armor


func __emit_power_change() -> void:
	power_point_changed.emit(power_points, max_power_points)
