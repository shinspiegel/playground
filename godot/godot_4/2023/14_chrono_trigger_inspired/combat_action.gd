class_name CombatAction extends Node2D

@export var actor: Actor


func use_action(_target: Actor) -> void:
	print_debug("WARN:: You forgot to override this function")

