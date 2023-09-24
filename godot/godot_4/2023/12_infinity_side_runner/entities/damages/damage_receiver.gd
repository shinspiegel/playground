class_name DamageReceiver extends Area2D

signal receive_damage(damage: Damage)

@export var damage_colddown: float = 0.3
@onready var colddown: Timer = $Colddown

func hit(damage: Damage) -> void:
	if colddown.time_left <= 0.0:
		receive_damage.emit(damage)
		colddown.start(damage_colddown)
