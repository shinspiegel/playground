extends Node

signal health_changed

@export var max_health: int = 100
@export var health: int = 100


func _ready() -> void:
	health = max_health


func change_health(amount: int) -> void:
	health = clampi(health + amount, 0, max_health)
	health_changed.emit()


func deal_damage(amount: int) -> void:
	change_health(-amount)
