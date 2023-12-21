class_name ElectrifiedWall extends Node2D

@export var is_active: bool = true
@export var enable_interactable: Interactable
@export var disable_interactable: Interactable

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	if enable_interactable:
		enable_interactable.interacted.connect(activate)

	if disable_interactable:
		disable_interactable.interacted.connect(deactivate)

	if is_active:
		animation_player.play("active")
	else:
		animation_player.play("deactive")


func activate() -> void:
	if not is_active:
		is_active = true
		animation_player.play("active")


func deactivate() -> void:
	if is_active:
		is_active = false
		animation_player.play("deactive")
