class_name StateManager extends Node2D

export var initial_state: NodePath

var states = {}
var current_state: BaseState = null


func _ready() -> void:
	setup_states()

	if not get_node(initial_state) == null:
		change_state(get_node(initial_state).name)


func setup_states() -> void:
	for node in get_children():
		if node is BaseState:
			states[node.name] = node
			node.player = get_parent()


func apply(delta: float) -> void:
	if not current_state == null:
		current_state.process(delta)
	else:
		print_debug("WARN:: No state to apply process")


func change_state(state_name: String) -> void:
	if not current_state == null:
		current_state.exit()

	current_state = null

	if not states[state_name] == null:
		current_state = states[state_name]
		current_state.enter()
	else:
		print_debug("WARN:: Failed to load state %s" % [state_name])
