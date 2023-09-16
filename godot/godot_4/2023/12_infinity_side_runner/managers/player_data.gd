extends Node

signal health_changed
signal health_zeroed
signal htealh_maxed

@export var max_health: int = 20
@export var health: int = 20


func _ready() -> void:
	reset()


func change_health(amount: int) -> void:
	health = clampi(health + amount, 0, max_health)
	health_changed.emit()
	if health >= max_health:
		htealh_maxed.emit()
	
	if health <= 0:
		health_zeroed.emit()


func deal_damage(amount: int) -> void:
	change_health(-amount)


func reset() -> void:
	health = max_health
