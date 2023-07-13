class_name StateManager extends Node

@export var actor: Node3D
@export var initial_state: NodePath
@export var state_list: Dictionary

var current_state: BaseState


func _ready() -> void:
	collect_all_states()
	load_initial_state()


func collect_all_states() -> void:
	for child in get_children():
		if child is BaseState:
			state_list[child.name] = child


func load_initial_state() -> void:
	if not initial_state == null:
		var state = get_node(initial_state)
		if not state == null and state_list.has(state.name):
			current_state = state
	elif get_child_count() > 0:
		current_state = get_child(0)
	
	if not current_state == null:
		current_state.enter()


func change_state(next: String) -> void:
	if state_list.has(next): 
		if not current_state == null:
			current_state.exit()
		current_state = state_list.get(next)
		current_state.enter()
