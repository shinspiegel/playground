class_name Health extends Node

signal changed(current: int, max_health: int)
signal zeroed()
signal maxed()

@export var max_health: int = 10

var __current_health: int


func _ready() -> void:
	reset()


func get_current_value() -> int:
	return __current_health


func get_max_value() -> int:
	return max_health


func deal_damage(damage: Damage) -> void:
	change_health(-damage.amount)


func change_health(amount: int) -> void:
	__current_health = clampi(__current_health + amount, 0, max_health)

	changed.emit(__current_health, max_health)

	if __current_health == 0:
		zeroed.emit()

	if __current_health == max_health:
		maxed.emit()


func reset() -> void:
	change_health(max_health)
