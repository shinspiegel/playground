class_name Damage extends Resource

@export_group("Value", "damage_")
@export var damage_min: int = 0
@export var damage_max: int = 1


@export_group("Critical", "critical_")
@export_range(0.0, 1.0, 0.1) var critical_change: float = 0.1
@export_range(1.0, 5.0, 0.1) var critical_multiplier: float = 2.0

var amount: int
var is_critical: bool


func get_clone() -> Damage:
	var clone: Damage = self.duplicate(true)
	
	if randf_range(0.0, 1.0) < critical_change: 
		clone.is_critical = true
		clone.amount = randi_range(damage_min, damage_max)
	else: 
		clone.is_critical = false
		clone.amount = ceili(float(randi_range(damage_min, damage_max)) * critical_multiplier)
	
	return clone
