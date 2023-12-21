class_name Interactable extends Node2D

signal interacted()


@onready var outlined_sprite_2d: OutlinedSprite2D = $OutlinedSprite2D
@onready var area_2d: Area2D = $Area2D


var __is_active: bool = false


func _ready() -> void:
	area_2d.body_entered.connect(on_area_enter)
	area_2d.body_exited.connect(on_area_exit)


func interact() -> void:
	interacted.emit()


func on_area_enter(body: Node2D) -> void:
	if body is Player:
		outlined_sprite_2d.enable()
		body.add_interactable(self)
		__is_active = true


func on_area_exit(body: Node2D) -> void:
	if body is Player:
		outlined_sprite_2d.disable()
		body.clean_interactable()
		__is_active = false
