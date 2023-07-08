class_name DamageNumber extends Node3D

@export_subgroup("Size", "scale_")
@export var scale_max: Vector3 = Vector3(2, 2, 2)
@export var scale_min: Vector3 = Vector3(0.8, 0.8, 0.8)
@export_range(0.0, 1.0, 0.1) var scale_in: float = 0.3
@export_range(0.0, 1.0, 0.1) var scale_out: float = 0.2

@export_subgroup("Position", "pos_")
@export var pos_up: Vector3 = Vector3(0, 1, 0)
@export var pos_down: Vector3 = Vector3(0, -1, 0)
@export_range(0.0, 1.0, 0.1) var pos_in: float = 0.2
@export_range(0.0, 1.0, 0.1) var pos_out: float = 0.3

@export_subgroup("Color", "color_")
@export var color_base: Color = Color(1, 1, 1)
@export var color_critical: Color = Color(1, 0, 0)


@onready var label: Label3D = $Label3D

func _ready() -> void:
	animate()



func apply_damage(damage: Damage) -> void:
	if damage.is_critical:
		label.modulate = color_critical
	else:
		label.modulate = color_base
	
	label.text = str(damage.amount)


func animate() -> void:
	var tw_scale = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tw_scale.tween_property(label, "scale", scale_max, scale_in)
	tw_scale.tween_property(label, "scale", scale_min, scale_out)
	tw_scale.tween_callback(queue_free)
	tw_scale.play()
	
	var tw_pos = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
	tw_pos.tween_property(label, "position", pos_up, pos_in).set_ease(Tween.EASE_OUT)
	tw_pos.tween_property(label, "position", pos_down, pos_out).set_ease(Tween.EASE_IN)
	tw_pos.play()


