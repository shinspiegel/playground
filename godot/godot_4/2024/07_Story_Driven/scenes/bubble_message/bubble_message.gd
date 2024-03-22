class_name BubbleMessage extends Node2D

@export var message_data: MessageData

@onready var panel: Panel = %Panel
@onready var label: RichTextLabel = %Label
@onready var timer: Timer = %Timer

var text_width_multipleir: float = 3.0
var text_padding: float = 40
var text_speed: float = 0.05
var fadeout_time: float = 0.3

var final_speed: float = 0.0
var final_width: float = 0.0


func _ready() -> void:
	timer.timeout.connect(on_timeout)

	label.text = "[center]" + message_data.text + "[/center]"
	label.visible_ratio = 0.0
	panel.size = Vector2(0, 80)
	panel.position = Vector2(0, -80)

	final_speed = MessageManager.remove_bbcode(message_data.text).length() * text_speed * message_data.speed_ratio
	final_width = label.get_theme_default_font().get_string_size(MessageManager.remove_bbcode(message_data.text)).x * text_width_multipleir + text_padding

	show_bubble()


func show_bubble() -> void:
	var tw = create_tween().set_parallel(true).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	tw.tween_property(label, "visible_ratio", 1, final_speed)
	tw.tween_property(panel, "size", Vector2(final_width, 80), final_speed)
	tw.tween_property(panel, "position", Vector2((float(final_width)/2) * -1 , -80), final_speed)
	tw.play()
	tw.finished.connect(func(): timer.start(message_data.duration))


func on_timeout() -> void:
	var tw = create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(self, "modulate", Color(0,0,0,0), fadeout_time)
	tw.play()
	await tw.finished
	queue_free()
