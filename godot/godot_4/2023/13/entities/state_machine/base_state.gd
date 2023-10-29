class_name BaseState extends Node2D

signal next_state(state: String)

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
