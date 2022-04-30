class_name BaseState
extends Node

onready var state_id := name
onready var entity: Entity = get_parent().get_parent()
onready var stateManager = get_parent()

func _enter_state() -> void:
	print("Entered State")
	pass

func _exit_state() -> void:
	print("Exit State")
	pass

func _apply_state(delta: float) -> void:
	print("Apply State")
	pass
