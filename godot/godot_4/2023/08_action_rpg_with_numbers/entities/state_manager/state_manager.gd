class_name StateManager extends Node

@export var initial_state: BaseState
@export var state_list: Dictionary

var current_state: BaseState


func _ready() -> void:
	__collect_all_states()
	__load_initial_state()


func __collect_all_states() -> void:
	for child in get_children():
		if child is BaseState:
			state_list[child.name] = child


func __load_initial_state() -> void:
	if not initial_state == null:
		if not initial_state == null and state_list.has(initial_state):
			current_state = initial_state
	elif get_child_count() > 0:
		current_state = get_child(0)
	
	if not current_state == null:
		current_state.enter()


func has_state() -> bool:
	if not current_state == null:
		return true
	return false


func apply_current_state(delta: float) -> void:
	if has_state():
		current_state.apply(delta)


func change_state(next: String) -> void:
	if state_list.has(next): 
		if not current_state == null:
			current_state.exit()
		
		current_state = state_list.get(next)
		current_state.enter()
