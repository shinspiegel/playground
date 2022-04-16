extends Node2D
class_name BaseState

signal finished_state(next_state: String)

var player: Player


func on_process(delta:float):
	pass

func on_enter():
	pass

func on_exit():
	pass

func change_state(state: String):
	emit_signal("finished_state", state)
