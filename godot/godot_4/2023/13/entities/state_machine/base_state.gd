class_name BaseState extends Node2D

signal state_ended(next_state: String)

@export var state_machine: StateMachine

func enter() -> void:
	pass


func exit() -> void:
	pass


func process(_delta: float) -> void:
	pass


func physics_process(_delta: float) -> void:
	pass


func input(_event: InputEvent) -> void:
	pass
