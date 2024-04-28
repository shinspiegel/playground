class_name StateMachine extends Node2D

signal state_changed(state_name: String)

@export var initial_state: BaseState

var states: Dictionary
var current: BaseState


func _ready() -> void:
	__load_child_states()


func update(delta: float) -> void:
	current.update(delta)


func get_current_name() -> String:
	return current.name


func change_by_state(state: BaseState) -> void:
	change_by_name(state.name)


func change_by_name(state: String) -> void:
	if not states.has(state):
		push_warning("invalid state")
		return

	if states.get(state) == current:
		return

	if not current == null:
		current.exit()

	current = states.get(state)
	current.enter()
	state_changed.emit(state)


func change_initial() -> void:
	if states.size() <= 0:
		push_error("No state in state machine")
		return

	if initial_state:
		change_by_name(initial_state.name)

	else:
		change_by_name(states.keys()[0])


func __load_child_states() -> void:
	for child in get_children():
		if child is BaseState:
			child.state_machine = self
			states[child.name] = child
		else:
			push_warning("childen isn't a state")
