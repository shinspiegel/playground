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
	setup_target()
	setup_states()


func apply(delta: float) -> void:
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
		state_entered.emit(current_state.name)
		SignalBus.state_exited_for.emit(target, current_state.name)
		current_state.exit()
	
	current_state = null
	
	if states.has(state_name):
		current_state = states[state_name]
		current_state.enter()
		state_exited.emit(current_state.name)
		SignalBus.state_entered_for.emit(target, current_state.name)
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
	
	if not initial_path.is_empty():
		last_state = get_node(initial_path).name
	elif get_child_count() > 0:
		last_state = get_children()[0].name
	else:
		print_debug("WARN:: Failed to load default state for last_state")
	
	if state_history.size() > 0:
		last_state = state_history[0]
	
	return last_state


func setup_target() -> void:
	if not target_path.is_empty():
		target = get_node(target_path)
	else:
		target = get_parent()


func setup_states() -> void:
	for node in get_children():
		if node is BaseState:
			states[node.name] = node
			node.target = target
	
	if not initial_path.is_empty():
		change_state(get_node(initial_path).name)
	elif get_child_count() > 0:
		change_state(get_children()[0].name)
	else:
		print_debug("WARN:: Failed to set initial state")
