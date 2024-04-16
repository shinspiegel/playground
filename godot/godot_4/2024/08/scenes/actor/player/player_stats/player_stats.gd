class_name PlayerStats extends Resource

signal hp_changed()
signal hp_zeroed()

@export var max_hp: int = 50
@export var curr_hp: int = 50


func _init() -> void:
	curr_hp = max_hp
	hp_changed.emit()


func deal_damage(amount: int) -> void:
	curr_hp = clampi(curr_hp - amount, 0, max_hp)
	hp_changed.emit()

	if curr_hp <= 0:
		hp_zeroed.emit()

