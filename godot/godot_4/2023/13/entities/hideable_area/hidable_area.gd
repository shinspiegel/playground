class_name HideableArea extends Area2D

@export_range(0.1, 3.0, 0.1) var duration: float = 0.2

@onready var sprite: OutlinedSprite2D = $OutlinedSprite2D
@onready var helper_text: Node2D = $HelperText

var __player: Player
var __is_active: bool = false

func _ready() -> void:
	body_entered.connect(on_body_enter)
	body_exited.connect(on_body_exit)
	helper_text.modulate = Color(0,0,0,0)


func _process(_delta: float) -> void:
	if __is_active and __player and __player.get_state_name() == "hide":
		sprite.disable()
		__tween_helper_text(Color(0,0,0,0))
		__is_active = false


func on_body_enter(body: Node2D) -> void:
	if body is Player:
		__player = body
		__is_active = true
		body.enable_hide()
		sprite.enable()
		__tween_helper_text(Color(1,1,1,1))


func on_body_exit(body: Node2D) -> void:
	if body is Player:
		body.disable_hide()
		__player = null
		__is_active = false
		sprite.disable()
		__tween_helper_text(Color(0,0,0,0))


## Private Functions


func __tween_helper_text(color: Color) -> void:
	var tween = create_tween();
	tween.tween_property(helper_text, "modulate", color, duration)
