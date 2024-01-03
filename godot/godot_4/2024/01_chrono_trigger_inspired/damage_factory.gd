class_name DamageFactory extends Resource

@export var damage_bonus: int = 0
@export_range(0.0, 1.0, 0.1) var damage_variation: float = 0.1
@export_range(0.0, 3.0, 0.1) var damage_bonus_ratio: float = 0.0
@export_range(1.0, 5.0, 0.1) var crit_bonus: float = 1.5
@export_range(0.0, 1.0, 0.1) var crit_change: float = 0.1


func generate(base_attack: int) -> Damage:
	var damage = Damage.new()
	var variation = (base_attack + damage_bonus) * damage_variation
	
	damage.amount = base_attack + damage_bonus + randi_range(-variation, variation)

	if randf_range(0.0, 1.0) < crit_change:
		damage.is_critical = true
		damage.amount *=  crit_change
	
	return damage
