class_name BonusEffect extends Resource

@export_group("Bonus Effect")
@export_enum(
	"health_max",
	"health_current",
	"stat_speed",
) var property: String = "health_current"
@export_enum("add", "set") var affect_type: String = "add"
@export_range(0.0, 10.0, 0.1) var amount: float = 0.0
@export_range(0.0, 10.0, 0.1) var duration: float = 0.0
@export_range(0.0, 10.0, 0.1) var tick: float = 0.0

var is_instant: bool: 
	get: 
		return true if duration <= 0.0 and tick <= 0.0 else false
