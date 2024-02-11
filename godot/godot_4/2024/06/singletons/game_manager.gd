extends Node

signal state_changed()

enum MODE {WORLD, BATTLE}

var __current_mode: MODE = MODE.WORLD


func get_state() -> MODE:
	return __current_mode


func change_to_battle() -> void: change_state_to(MODE.BATTLE)
func change_to_world() -> void: change_state_to(MODE.WORLD)
func change_state_to(state: MODE) -> void:
	if not state == __current_mode:
		__current_mode = state
		state_changed.emit()

