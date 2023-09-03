class_name DamageNumber extends Node2D

@export_group("Damage")
@export var damage: Damage

@export_group("Colors", "color_")
@export var color_fill = Color(0, 0, 0)
@export var color_outline  = Color(0.8, 0.35, 0.1)
@export var color_fill_critical = Color(1, 1, 1)
@export var color_outline_critical = Color(0.6, 0.03, 0.03)

@onready var label: Label = $Node2D/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.animation_finished.connect(on_animation_finished)
	__apply_label_changes()


func on_animation_finished(_anim: StringName) -> void:
	queue_free()


func __apply_label_changes() -> void:
	if damage.is_critical:
		label.set("theme_override_colors/font_color", color_outline_critical)
		label.set("theme_override_colors/font_outline_color", color_outline_critical)
	else:
		label.set("theme_override_colors/font_color", color_outline)
		label.set("theme_override_colors/font_outline_color", color_fill)
	
	label.text = str(damage.amount)
