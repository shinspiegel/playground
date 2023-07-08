class_name DamageFactory extends Resource

@export_group("Damage", "range_")
@export_range(0, 20, 1) var range_min: int = 1
@export_range(0, 20, 1) var range_max: int = 10

@export_group("Critical", "critical_")
@export_range(1.0, 5.0, 0.1) var critical_multiplier: float = 2.0
@export_range(0.0, 1.0, 0.1) var critical_chance: float = 0.1


func generate_damage() -> Damage:
	var dmg = Constants.DMG.RESOURCE.new()
	dmg.is_critical = randomize_critical()
	dmg.amount = randomize_damage(dmg.is_critical)
	return dmg


func randomize_critical() -> bool:
	var rng = randf_range(0.0, 1.0)
	if rng < critical_chance:
		return true
	return false


func randomize_damage(is_crit: bool = false) -> int:
	var amount = randf_range(range_min, range_max)
	if is_crit:
		amount = int(float(amount) * critical_multiplier)
	
	return int(floor(amount))
