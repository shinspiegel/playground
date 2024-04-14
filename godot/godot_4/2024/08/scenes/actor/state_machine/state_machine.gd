class_name StateMachine extends Node2D

signal state_changed(state: String)

@export var initial_state: BaseState

var states: Dictionary
var current: BaseState


func _ready() -> void:
	__load_child_states()
	__start_initial()


func update(delta: float) -> void:
	current.update(delta)


func change_state(state: String) -> void:
	if not states.has(state):
		push_warning("invalid state")
		return

	if not states.get(state) == current:
		if not current == null:
			current.exit()

		current = states.get(state)
		current.enter()
		state_changed.emit(state)


func __load_child_states() -> void:
	for child in get_children():
		if child is BaseState:
			child.state_machine = self
			states[child.name] = child


func __start_initial() -> void:
	if states.size() <= 0:
		push_error("No state in state machine")
		return

	if initial_state:
		change_state(initial_state.name)

	else:
		change_state(states.keys()[0])
