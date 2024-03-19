class_name InteractableItem extends Node2D

signal interacted()

@export var active: bool = true

@onready var sprite: OutlinedSprite = %OutlinedSprite
@onready var interactable: Interactable = %Interactable


func _ready() -> void:
	interactable.focus.connect(on_focus)
	interactable.blur.connect(on_blur)
	interactable.interacted.connect(on_interact)


func interact() -> void:
	if active:
		interacted.emit()


func on_focus() -> void:
	if active:
		sprite.enable()


func on_blur() -> void:
	if active:
		sprite.disable()


func on_interact() -> void:
	if active:
		interact()

