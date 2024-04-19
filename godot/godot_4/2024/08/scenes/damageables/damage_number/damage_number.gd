class_name DamageNumber extends Node2D

@export var damage: Damage
@onready var number_label: Label = %NumberLabel


func _ready() -> void:
	if damage == null: 
		push_error("missing damage")
		return

	number_label.text = "%s" % [damage.amount]

	if damage.is_critical:
		number_label.set("theme_override_colors/font_color", Color(1, 0.25, 0.1))
		number_label.set("theme_override_colors/font_outline_color", Color(1,1,1))
		number_label.set("theme_override_constants/outline_size", 8)

