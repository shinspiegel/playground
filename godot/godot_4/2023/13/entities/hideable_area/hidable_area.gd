class_name HideableArea extends Area2D

@export_range(0.1, 3.0, 0.1) var duration: float = 0.2

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var helper_text: Node2D = $HelperText

var __player: Player
var __is_active: bool = false

func _ready() -> void:
	body_entered.connect(on_body_enter)
	body_exited.connect(on_body_exit)
	helper_text.modulate = Color(0,0,0,0)
	__update_outline(0.0)


func _process(delta: float) -> void:
	if __is_active and __player and __player.get_state_name() == "hide":
		__tween_countour(1.0, 0.0)
		__tween_helper_text(Color(0,0,0,0))
		__is_active = false


func on_body_enter(body: Node2D) -> void:
	if body is Player:
		__player = body
		__is_active = true
		body.enable_hide()
		__tween_helper_text(Color(1,1,1,1))
		__tween_countour(0.0, 1.0)


func on_body_exit(body: Node2D) -> void:
	if body is Player:
		body.disable_hide()
		__player = null
		__is_active = false
		__tween_countour(1.0, 0.0)
		__tween_helper_text(Color(0,0,0,0))


## Private Functions


func __tween_helper_text(color: Color) -> void:
	var tween = get_tree().create_tween();
	tween.tween_property(helper_text, "modulate", color, duration)


func __tween_countour(from: float, to: float) -> void:
	var tween = get_tree().create_tween();
	tween.tween_method(__update_outline, from, to, duration);


func __update_outline(value: float) -> void:
	sprite_2d.material.set_shader_parameter("line_thickness", value)
