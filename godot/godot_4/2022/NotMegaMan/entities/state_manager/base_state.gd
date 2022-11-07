class_name BaseState extends Node2D

signal state_finished(next_state)

var target: Node2D = null


func _ready() -> void:
	pass


func enter() -> void:
	pass


func exit() -> void:
	pass


func process(_delta: float) -> void:
	pass


func receive_message(_id: String, _message = null) -> void:
	pass
