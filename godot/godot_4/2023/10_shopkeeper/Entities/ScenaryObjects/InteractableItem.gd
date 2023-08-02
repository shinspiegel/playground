class_name InteractableItem extends Node2D

@onready var item_sprite: Sprite2D = $ItemSprite
@onready var interactable: Interactable = $Interactable


func _ready() -> void:
	interactable.focus.connect(enter)
	interactable.blur.connect(exit)
	item_sprite.material.set_shader_parameter("line_thickness", 0.0)


func enter() -> void:
	item_sprite.material.set_shader_parameter("line_thickness", 1.0)


func exit() -> void:
	item_sprite.material.set_shader_parameter("line_thickness", 0.0)
