class_name StateManager extends Node2D

signal state_entered(state)
signal state_exited(state)

export var max_history_lengh: int = 3
export var initial_path: NodePath
export var target_path: NodePath

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
		emit_signal("state_exited", current_state.name)
		current_state.exit()

	current_state = null

	if not states[state_name] == null:
		current_state = states[state_name]
		current_state.enter()
		emit_signal("state_entered", current_state.name)

	else:
		print_debug("WARN:: Failed to load state %s" % [state_name])


func add_state_history(state_name: String) -> void:
	state_history.push_front(state_name)

	if state_history.size() > max_history_lengh:
		state_history.pop_back()


func get_last_state() -> String:
	var last_state = "Idle"

	if state_history.size() > 0:
		var reversed_list = state_history.duplicate(true)
		reversed_list.invert()

		for item in reversed_list:
			if not item == "Hit":
				last_state = item

	return last_state


## SIGNAL METHODS

## SETUP METHODS


func setup_target() -> void:
	if not get_node(target_path) == null:
		target = get_node(target_path)
	else:
		target = get_parent()


func setup_states() -> void:
	for node in get_children():
		if node is BaseState:
			states[node.name] = node
			node.target = target

	if not get_node(initial_path) == null:
		change_state(get_node(initial_path).name)
	elif get_child_count() > 0:
		change_state(get_children()[0].name)
