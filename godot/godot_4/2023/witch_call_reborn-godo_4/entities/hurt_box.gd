class_name HurtBox extends Area2D

signal hit_received(hit_box: HitBox)
@onready var shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	area_entered.connect(on_area_enter)


func enable() -> void:
	set_shape_disabled(false)


func disable() -> void:
	set_shape_disabled(true)


func set_shape_disabled(value: bool) -> void:
	shape.disabled = value


func on_area_enter(hit_box) -> void:
	if hit_box is HitBox:
		hit_received.emit(hit_box)
