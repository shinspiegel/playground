class_name StateManager
extends Node2D

var STATE_LIST = {}
var CURRENT_STATE: BaseState
var INITIAL_STATE = "Idle"

func _ready() -> void:
	for state in get_children():
		STATE_LIST[state.name] = state
	
	CURRENT_STATE = STATE_LIST[INITIAL_STATE]


func _apply_current_state(delta:float) -> void:
	CURRENT_STATE._apply_state(delta)


func _change_state(state_name: String) -> void:
	for key in STATE_LIST:
		if key == state_name:
			CURRENT_STATE._exit_state()
			CURRENT_STATE = STATE_LIST[state_name]
			CURRENT_STATE._enter_state()
