class_name DamageReceiver extends Area2D

signal receive_damage(damage: Damage)

@export var health: Health


func hit(damage: Damage) -> void:
	receive_damage.emit(damage)
	
	if health:
		health.deal_damage(damage)
