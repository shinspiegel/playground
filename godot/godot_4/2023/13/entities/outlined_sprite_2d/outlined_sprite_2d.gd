class_name OutlinedSprite2D extends Sprite2D

@export_range(0.0, 1.0, 0.1) var initial_thickness: float = 1.0
@export_range(0.0, 1.0, 0.1) var thickness: float = 1.0
@export var smooth: bool = true
@export_range(0.0, 1.0, 0.1) var duration: float = 0.3

var __is_outlined: bool = true


func _ready() -> void:
	if initial_thickness <= 0.0:
		__is_outlined = false
	__update_outline(initial_thickness)


func is_outlined() -> bool:
	return __is_outlined


func enable() -> void:
	if not __is_outlined:
		if smooth: __tween_countour(0.0, thickness)
		else: __update_outline(thickness)
		__is_outlined = true


func disable() -> void:
	if __is_outlined:
		if smooth: __tween_countour(thickness, 0.0)
		else: __update_outline(0.0)
		__is_outlined = false


## Private Methods

func __tween_countour(from: float, to: float) -> void:
	var tween = create_tween();
	tween.tween_method(__update_outline, from, to, duration);


func __update_outline(value: float) -> void:
	material.set_shader_parameter("line_thickness", value)
