class_name CombatAction extends Node2D

@export var actor: Actor
@export var require_target: bool = true


func use_action(_target: Actor = null) -> void:
	print_debug("WARN:: You forgot to override this function")

