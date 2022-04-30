extends Node2D
class_name InputHandler

onready var stateMachine : StateMachine = get_node("../StateMachine")
var character


func _ready() -> void:
	character = get_owner()


func act_input(action: String):
	stateMachine._delegate_input(action)
