class_name InteractableItem extends Node2D

@export var is_active: bool = false

@export_group("sprite", "sprite_")
@export_range(0.0, 1.0, 0.1) var sprite_initial_thickness: float = 1.0
@export_range(0.0, 1.0, 0.1) var sprite_thickness: float = 1.0
@export var sprite_smooth: bool = true
@export_range(0.0, 1.0, 0.1) var sprite_duration: float = 0.3

@onready var sprite_group: Node2D = %SpriteGroup
@onready var interactable: Interactable = %Interactable

var is_outlined: bool = true


func _ready() -> void:
	interactable.focus.connect(on_focus)
	interactable.blur.connect(on_blur)
	interactable.interacted.connect(on_interact)

	if sprite_initial_thickness <= 0.0:
		is_outlined = false
	__update_outline(sprite_initial_thickness)


func interact() -> void:
	push_warning("no interaction assigned")


func enable() -> void:
	if not is_outlined:
		if sprite_smooth: 
			__tween_countour(0.0, sprite_thickness)
		else: 
			__update_outline(sprite_thickness)

		is_outlined = true


func disable() -> void:
	if is_outlined:
		if sprite_smooth: 
			__tween_countour(sprite_thickness, 0.0)
		else: 
			__update_outline(0.0)

		is_outlined = false


func on_focus() -> void:
	if is_active:
		enable()


func on_blur() -> void:
	if is_active:
		disable()


func on_interact() -> void:
	if is_active:
		interact()


func __tween_countour(from: float, to: float) -> void:
	var tween = create_tween();
	tween.tween_method(__update_outline, from, to, sprite_duration);


func __update_outline(value: float) -> void:
	material.set_shader_parameter("line_thickness", value)
