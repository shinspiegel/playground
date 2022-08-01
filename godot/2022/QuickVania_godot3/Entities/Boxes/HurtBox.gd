class_name HurtBox extends Area2D

signal hit_received(hit_box)

onready var shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	var con = connect("area_entered", self, "on_area_enter")
	if not con == OK:
		print_debug("INFO:: Failed to connect [%s]" % [name])


func enable() -> void:
	set_shape_disabled(false)


func disable() -> void:
	set_shape_disabled(true)


func set_shape_disabled(value: bool) -> void:
	shape.disabled = value


## SIGNAL METHODS


func on_area_enter(body) -> void:
	if body is HitBox:
		emit_signal("hit_received", body)

## SETUP METHODS
