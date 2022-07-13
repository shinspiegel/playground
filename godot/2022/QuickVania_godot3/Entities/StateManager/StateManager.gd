class_name StateManager extends Node2D

export var initial_path: NodePath
export var target_path: NodePath

var target = null
var states = {}
var current_state: BaseState = null


func _ready() -> void:
	setup_target()
	setup_states()


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
			node.player = get_parent()
			node.target = target

	if not get_node(initial_path) == null:
		change_state(get_node(initial_path).name)
