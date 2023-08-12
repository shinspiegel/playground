class_name IngredientBonus extends Resource

@export_enum(
	"diff_slider_speed", 
	"diff_good", 
	"diff_ok", 
	"diff_bad", 
	"diff_fail",
) var type: String = "diff_good"
@export_range(-10.0, 10.0, 0.1) var amount: float = 1.0

