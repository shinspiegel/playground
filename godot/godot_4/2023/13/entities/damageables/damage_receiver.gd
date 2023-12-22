class_name DamageReceiver extends Area2D

signal receive_damage(damage: Damage)

@export var health: Health
@export var damage_number_position: Node2D
@export var colddown: Timer


func hit(damage: Damage) -> void:
	if colddown:
		if colddown.is_stopped():
			colddown.start()
			__apply_damage(damage)
	else:
		__apply_damage(damage)


func __apply_damage(damage: Damage):
	receive_damage.emit(damage)

	if damage_number_position:
		GameManager.spawn_damage_number.emit(damage_number_position.global_position, damage)
	else:
		GameManager.spawn_damage_number.emit(global_position, damage)


	if health:
		health.deal_damage(damage)
