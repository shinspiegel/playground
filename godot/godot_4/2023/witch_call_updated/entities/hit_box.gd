class_name HitBox extends Area2D

signal hit(hurt_box: HurtBox)
@export var damage: Damage = Damage.new()
@onready var shape: CollisionShape2D = $CollisionShape2d


func _ready() -> void:
	area_entered.connect(on_area_enter)


func enable() -> void:
	set_shape_disabled(false)


func disable() -> void:
	set_shape_disabled(true)


func set_shape_disabled(value: bool) -> void:
	shape.set_deferred("disabled", value)


func on_area_enter(hurt_box: Area2D) -> void:
	if hurt_box is HurtBox:
		hit.emit(hurt_box)
