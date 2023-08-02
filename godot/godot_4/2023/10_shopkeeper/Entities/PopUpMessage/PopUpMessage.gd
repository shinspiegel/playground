class_name PopUpMessage extends Node2D

@export var text: String = ""
@export var interactable: Interactable
@export var distance: Vector2 = Vector2(0, -64)
@export_range(0.0, 1.0, 0.1) var time: float = 0.3
@onready var label: Label = $LabelWrapper/Label
@onready var label_wrapper: Node2D = $LabelWrapper


func _ready() -> void:
	if interactable:
		interactable.focus.connect(on_focus)
		interactable.blur.connect(on_blur)
	label.text = text
	label_wrapper.modulate = Color(1,1,1,0)
	label_wrapper.position = Vector2.ZERO


func on_focus() -> void:
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT_IN).set_parallel(true)
	tween.tween_property(label_wrapper, "position", distance, time)
	tween.tween_property(label_wrapper, "modulate", Color(1,1,1,1), time)


func on_blur() -> void:
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT_IN).set_parallel(true)
	tween.tween_property(label_wrapper, "position", Vector2.ZERO, time)
	tween.tween_property(label_wrapper, "modulate", Color(1,1,1,0), time)
