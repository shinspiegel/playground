class_name DamageReceiver extends Area2D

signal receive_damage(damage: Damage)

@export var colddown: Timer


func hit(dmg: Damage) -> void:
	if colddown:
		if colddown.is_stopped():
			colddown.start()
			receive_damage.emit(dmg)
	else:
		receive_damage.emit(dmg)
	


