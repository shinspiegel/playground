class_name DamageReceiver extends Area2D

signal receive_damage(damage: Damage)

@export var health: Health
@export var damage_number_position: Node2D
@export var colddown: Timer
@export var variation: float = 16


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
		var target_position = damage_number_position.global_position
		target_position += Vector2(randf_range(-variation, variation),randf_range(-variation, variation))
		GameManager.spawn_damage_number.emit(target_position, damage)
	else:
		GameManager.spawn_damage_number.emit(global_position, damage)


	if health:
		health.deal_damage(damage)
