class_name DamageReceiver extends Area2D

signal receive_damage(damage: Damage)

@export var health: Health
@export var damage_number_position: Node2D


func hit(damage: Damage) -> void:
	receive_damage.emit(damage)

	if damage_number_position:
		GameManager.spawn_damage_number.emit(damage_number_position.global_position, damage)
	else:
		GameManager.spawn_damage_number.emit(global_position, damage)


	if health:
		health.deal_damage(damage)
