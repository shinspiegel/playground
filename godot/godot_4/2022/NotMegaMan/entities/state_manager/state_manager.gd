class_name StateManager extends Node2D

signal state_entered(state)
signal state_exited(state)

@export var max_history_lengh: int = 3
@export var initial_path: NodePath
@export var target_path: NodePath

var target = null
var states = {}
var current_state: BaseState = null
var state_history = []


func _ready() -> void:
	__setup_target()
	__setup_states()


func apply_state(delta: float) -> void:
	if not current_state == null:
		current_state.process(delta)
	else:
		print_debug("WARN:: No state to apply process")


func change_state(state_name: String) -> void:
	if state_name == null:
		return
	
	if not current_state == null and current_state.name == state_name:
		return
	
	if not current_state == null:
		add_state_history(current_state.name)
		state_exited.emit(current_state.name)
		current_state.exit()
	
	current_state = null
	
	if states.has(state_name):
		current_state = states[state_name]
		current_state.enter()
		state_entered.emit(current_state.name)
	else:
		print_debug("WARN:: Failed to load state %s" % [state_name])


func send_message(id: String, message) -> void:
	current_state.receive_message(id, message)


func add_state_history(state_name: String) -> void:
	state_history.push_front(state_name)
	
	if state_history.size() > max_history_lengh:
		state_history.pop_back()


func get_last_state() -> String:
	var last_state: String
	var initial_state = __get_initial_state()
	
	if state_history.size() > 0:
		last_state = state_history[0]
	
	elif not initial_state == null:
		last_state = get_node(initial_path).name
	
	elif __get_states_children().size() > 0:
		last_state = __get_states_children()[0].name
	
	else:
		print_debug("WARN:: Failed to load the last state")
	
	return last_state


## PRIVATE


func __get_initial_state() -> BaseState:
	var initial_state = get_node(initial_path)
		
	if initial_state is BaseState:
		return initial_state
	else:
		return null


func __get_states_children() -> Array[BaseState]:
	var base_state_children: Array[BaseState] = []
	
	for node in get_children():
		if node is BaseState:
			base_state_children.append(node)
	
	return base_state_children


func __setup_target() -> void:
	if not target_path.is_empty():
		target = get_node(target_path)
	else:
		target = get_parent()


func __setup_states() -> void:
	for state in __get_states_children():
		states[state.name] = state
		state.target = target
		if not state.state_finished.connect(change_state) == OK:
			print_debug("WARN:: Failed to connect state finished on [%s]" % [state.name])
	
	var initial_state = __get_initial_state()
	
	if not initial_state == null:
		change_state(initial_state.name)
		
	elif __get_states_children().size() > 0:
		change_state(__get_states_children()[0].name)
	
	else:
		print_debug("WARN:: Failed to set initial state")
