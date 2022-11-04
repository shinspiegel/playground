class_name HurtBox extends Area2D

signal hit_received(hit_box)

@onready var shape: CollisionShape2D = $CollisionShape2d


func _ready() -> void:
	if not area_entered.connect(on_area_enter) == OK:
		print_debug("WARN:: Failed to connect area entered")


func enable() -> void:
	set_shape_disabled(false)


func disable() -> void:
	set_shape_disabled(true)


func set_shape_disabled(value: bool) -> void:
	shape.disabled = value


func on_area_enter(hit_box) -> void:
	if hit_box is HitBox:
		hit_received.emit(hit_box)
