class_name InteractableItem extends Node2D

signal interacted()

@onready var item_sprite: Sprite2D = $ItemSprite
@onready var interactable: Interactable = $Interactable


func _ready() -> void:
	interactable.focus.connect(on_focus)
	interactable.blur.connect(on_blur)
	interactable.interacted.connect(on_interacted)
	item_sprite.material.set_shader_parameter("line_thickness", 0.0)


func on_interacted() -> void:
	interacted.emit()


func on_focus() -> void:
	if get_tree() == null: return
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(item_sprite.material, "shader_parameter/line_thickness", 1.0, 0.1)


func on_blur() -> void:
	if get_tree() == null: return
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(item_sprite.material, "shader_parameter/line_thickness", 0.0, 0.1)
