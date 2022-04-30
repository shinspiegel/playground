extends Node2D
class_name StateManager

signal state_changed(current_state: String)

@onready var player: Player = get_parent()

var states_list = {}
var current_state: BaseState


func _ready():
	_load_all_states()
	_set_initial_state()


func apply_state(delta: float):
	current_state.on_process(delta)


func change_state(state_name: String):
	var next_state = states_list[state_name]
	
	if not next_state == null:
		if not current_state == null:
			current_state.on_exit()
		
		current_state = next_state
		current_state.on_enter() 
		state_changed.emit(current_state.name)


func _load_all_states():
	for state in get_children():
		if state is BaseState:
			state.connect("finished_state", on_state_finished)
			state.player = player
			states_list[state.name] = state
	pass

func _set_initial_state():
	change_state(states_list.keys()[0])


func on_state_finished(next_state: String):
	change_state(next_state)
