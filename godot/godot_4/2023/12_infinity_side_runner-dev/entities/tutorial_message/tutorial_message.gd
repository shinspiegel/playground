class_name TutorialMessage extends Area2D

@export_multiline var message: String = ""
@export_group("Color", "color_")
@export var color_visible: Color = Color(1,1,1,1)
@export var color_invisible: Color = Color(1,1,1,0)

@onready var label: Label = $CanvasLayer/MessageWrapper/Label
@onready var message_wrapper: Control = $CanvasLayer/MessageWrapper


func _ready() -> void:
	body_entered.connect(on_body_enter)
	body_exited.connect(on_body_exit)
	
	label.text = message
	label.visible_ratio = 0.0
	
	message_wrapper.modulate = color_invisible


func on_body_enter(body: Node2D) -> void:
	if body is Player:
		__animate_color(color_visible, 1.0)


func on_body_exit(body: Node2D) -> void:
	if body is Player:
		__animate_color(color_invisible, 0.0)


func __animate_color(color: Color, text_display: float) -> void:
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN)
	tween.tween_property(message_wrapper, "modulate", color, 0.2)
	tween.tween_property(label, "visible_ratio", text_display, 0.4)
	tween.play()
