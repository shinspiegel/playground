class_name InteractableItem extends Node2D

signal interacted()

@onready var sprite: OutlinedSprite = %OutlinedSprite
@onready var interactable: Interactable = %Interactable

var is_outlined: bool = true


func _ready() -> void:
	interactable.focus.connect(on_focus)
	interactable.blur.connect(on_blur)
	interactable.interacted.connect(on_interact)


func interact() -> void:
	interacted.emit()


func on_focus() -> void:
	sprite.enable()


func on_blur() -> void:
	sprite.disable()


func on_interact() -> void:
	interact()

