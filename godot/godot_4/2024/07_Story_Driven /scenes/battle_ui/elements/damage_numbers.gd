class_name DamageNumbers extends Control

const DAMAGE_NUMBER = preload("res://scenes/battle_ui/elements/damage_number.tscn")


func _ready() -> void:
	BattleManager.target_damaged.connect(on_target_damage)


func on_target_damage(target: Actor, damage: Damage) -> void:
	var instance: DamageNumber = DAMAGE_NUMBER.instantiate()
	instance.damage = damage
	add_child(instance)
	instance.global_position = target.get_cursor_position()
