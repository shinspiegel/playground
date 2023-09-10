class_name Explosion extends Node2D

@export var item: InventoryBomb
@export var disable_area_frame: int = 20

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var damage_inflictor: DamageInflictor = $DamageInflictor


func _ready() -> void:
	animated_sprite_2d.animation_finished.connect(on_animation_finished)
	animated_sprite_2d.frame_changed.connect(on_frame_change)
	
	if disable_area_frame > 0:
		damage_inflictor.monitorable = true
		damage_inflictor.monitoring = true
	else:
		damage_inflictor.monitorable = false
		damage_inflictor.monitoring = false


func set_item(value: InventoryBomb) -> void:
	item = value
	scale = Vector2(item.explosive_area, item.explosive_area)
	damage_inflictor.damage = item.explosive_damage


func on_animation_finished() -> void:
	queue_free()


func on_frame_change() -> void:
	if animated_sprite_2d.frame == disable_area_frame:
		damage_inflictor.monitorable = false
		damage_inflictor.monitoring = false
