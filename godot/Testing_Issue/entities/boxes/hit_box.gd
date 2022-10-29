class_name HitBox extends Area2D

@export var damage: Damage = Damage.new()

@onready var shape: CollisionShape2D = $CollisionShape2d


func enable() -> void:
	set_shape_disabled(false)


func disable() -> void:
	set_shape_disabled(true)


func set_shape_disabled(value: bool) -> void:
	shape.set_deferred("disabled", value)
