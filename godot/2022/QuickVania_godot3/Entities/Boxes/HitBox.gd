class_name HitBox extends Area2D

export(Resource) var damage = Damage.new()

onready var shape: CollisionShape2D = $CollisionShape2D


func enable() -> void:
	set_shape_disabled(false)


func disable() -> void:
	set_shape_disabled(true)


func set_shape_disabled(value: bool) -> void:
	shape.disabled = value

## SIGNAL METHODS

## SETUP METHODS
