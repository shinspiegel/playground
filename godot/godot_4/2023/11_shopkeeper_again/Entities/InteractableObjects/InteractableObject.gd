class_name InteractableObject extends Node2D

@export var outline_color: Color = Color(1,1,1)
@onready var interactable: Interactable = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	interactable.interacted.connect(on_interact)
	interactable.focus.connect(on_focus)
	interactable.blur.connect(on_blur)
	sprite_2d.material.set("shader_parameter/line_thickness", 0.0)
	sprite_2d.material.set("shader_parameter/line_color", outline_color)


func _exit_tree() -> void:
	interactable.interacted.disconnect(on_interact)
	interactable.focus.disconnect(on_focus)
	interactable.blur.disconnect(on_blur)


func on_interact() -> void:
	print_debug("WARN::Not implemeted")


func on_focus() -> void:
	if get_tree() == null: return
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(sprite_2d.material, "shader_parameter/line_thickness", 1.0, 0.1)


func on_blur() -> void:
	if get_tree() == null: return
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(sprite_2d.material, "shader_parameter/line_thickness", 0.0, 0.1)
