class_name ElectrifiedWall extends Node2D

@export var is_active: bool = true
@export var enabler_list: Array[Interactable] = []
@export var disabler_list: Array[Interactable] = []

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	for entry in enabler_list:
		entry.interacted.connect(activate)

	for entry in disabler_list:
		entry.interacted.connect(deactivate)

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
