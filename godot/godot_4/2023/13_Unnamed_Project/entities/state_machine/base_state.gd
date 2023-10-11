class_name BaseState extends Node2D


func enter() -> void:
	pass


func exit() -> void:
	pass


func process_physics(delta: float) -> BaseState:
	return null


func process_frame(delta: float) -> BaseState:
	return null


func process_input(event: InputEvent) -> BaseState:
	return null
