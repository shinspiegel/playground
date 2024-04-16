class_name DamageGenerator extends Resource

@export var amount: int = 10
@export var impact: int = 10

@export_group("Variation", "variation_")
@export_range(0.0, 1.0, 0.1) var variation_amount: float = 0.2
@export_range(0.0, 1.0, 0.1) var variation_impact: float = 0.1
@export_range(0.0, 1.0, 0.1) var variation_crit_chance: float = 0.1
@export_range(1.0, 3.0, 0.1) var variation_crit_boost: float = 1.5


func generate(source: Vector2 = Vector2.ZERO) -> Damage:
	var new_damage: Damage = duplicate(true)

	new_damage.source_position = source
	new_damage.amount = randi_range(int(amount - (amount * variation_amount)), int(amount + (amount * variation_amount)))
	new_damage.impact = randi_range(int(impact - (impact * variation_impact)), int(impact + (impact * variation_impact)))

	if randf() < variation_crit_chance:
		new_damage.is_critical = true
		new_damage.amount = int(new_damage.amount * variation_crit_boost)
		new_damage.impact = int(new_damage.impact * variation_crit_boost)

	return new_damage

