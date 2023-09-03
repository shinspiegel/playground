class_name Explosion extends Node2D

@export var item: InventoryBomb
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var damage_inflictor: DamageInflictor = $DamageInflictor


func _ready() -> void:
	animated_sprite_2d.animation_finished.connect(on_animation_finished)


func set_item(value: InventoryBomb) -> void:
	item = value
	scale = Vector2(item.explosive_area, item.explosive_area)
	damage_inflictor.damage = item.explosive_damage


func on_animation_finished() -> void:
	queue_free()
