class_name BubbleMessage extends Node2D

@export var text: String = ""
@export var text_speed: float = 0.05
@export var text_width: int = 50
@export_range(0.1, 1.0, 0.1) var fadeout_time: float = 0.3
@onready var panel: Panel = %Panel
@onready var label: Label = %Label
@onready var timer: Timer = %Timer


func _ready() -> void:
	timer.timeout.connect(on_timeout)

	label.visible_ratio = 0.0
	panel.size = Vector2(0, 80)
	panel.position = Vector2(0, -80)

	show_bubble()


func show_bubble() -> void:
	var tw = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tw.tween_property(label, "visible_ratio", 1, text.length() * text_speed)
	tw.tween_property(panel, "size", Vector2(text.length() * text_width, 80), text.length() * text_speed)
	tw.tween_property(panel, "position", Vector2((float(text.length() * text_width)/2) * -1 , -80), text.length() * text_speed)
	tw.play()
	tw.finished.connect(func(): timer.start())


func on_timeout() -> void:
	var tw = create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(self, "modulate", Color(0,0,0,0), 0.3)
	tw.play()
	await tw.finished
	queue_free()
