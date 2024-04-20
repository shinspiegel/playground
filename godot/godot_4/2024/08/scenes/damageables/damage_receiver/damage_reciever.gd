class_name DamageReceiver extends Area2D

signal receive_damage(damage: Damage)

@export var colddown: Timer


func _ready() -> void:
	if colddown == null:
		push_error("ERROR: no colddown for damage")


func hit(dmg: Damage) -> void:
	if colddown.is_stopped():
		colddown.start()
		receive_damage.emit(dmg)


func can_hit() -> bool:
	if colddown.is_stopped():
		return true
	return false
