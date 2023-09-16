class_name DamageReceiver extends Area2D

signal receive_damage(damage: Damage)


func hit(damage: Damage) -> void:
	receive_damage.emit(damage)
