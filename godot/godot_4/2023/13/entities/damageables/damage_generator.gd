class_name DamageGenerator extends Resource

@export var max_damage: int = 10
@export var min_damage: int = 5
@export var impact: int = 10
@export_range(0.0, 1.0, 0.1) var critical_change: float = 0.1
@export_range(1.0, 5.0, 0.1) var critical_multiplier: float = 2.0


func random(source_position: Vector2) -> Damage:
	var damage = Damage.new()
	var is_critical = randf_range(0.0, 1.0) < critical_change
	
	
	if is_critical:
		damage.amount = randi_range(ceili(min_damage * critical_multiplier), ceili(max_damage * critical_multiplier))
		damage.is_critical = true
	else:
		damage.amount = randi_range(min_damage, max_damage)
	
	damage.impact = impact
	damage.source_position = source_position
	
	return damage
