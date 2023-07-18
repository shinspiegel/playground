class_name StateManager extends Node

signal state_changed(state:String)
signal state_existed(state:String)
signal state_entered(state:String)

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
		if not initial_state == null and state_list.has(initial_state.name):
			current_state = initial_state
		
	elif get_child_count() > 0:
		current_state = get_child(0)
	
	if not current_state == null:
		state_changed.emit(current_state.name)
		current_state.enter()
		state_entered.emit(current_state.name)


func get_current_name() -> BaseState:
	return current_state


func get_current_state_name() -> String:
	return current_state.name


func apply_current_state(delta: float) -> void:
	if current_state == null: return
	current_state.apply(delta)


func change_state(next: String) -> void:
	if state_list.has(next) and not current_state.name == next:
		if not current_state == null:
			current_state.exit()
			state_existed.emit(current_state.name)
		
		current_state = state_list.get(next)
		state_changed.emit(current_state.name)
		
		current_state.enter()
		state_entered.emit(current_state.name)


func send_message(id: String, message ) -> void:
	if current_state == null: return
	current_state.receive_message(id, message)
