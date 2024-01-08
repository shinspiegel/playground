class_name Damage extends Resource

@export var amount: int = 0
@export var is_critical: bool = false
@export var min_damage: int = 1


func apply_defense(defense: int) -> Damage:
	amount = clamp(amount - defense, min_damage, amount)
	return self
