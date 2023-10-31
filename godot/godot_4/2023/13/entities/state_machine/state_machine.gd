class_name StateMachine extends Node2D

signal state_changed(state: String)

@export var initial_state: BaseState

var __states = {}
var __current_state: BaseState


func _ready() -> void:
	__add_states()
	__enter_initial_state()


func _input(event: InputEvent) -> void:
	if __current_state:
		__current_state.input(event)


func _process(delta: float) -> void:
	if __current_state:
		__current_state.process(delta)


func _physics_process(delta: float) -> void:
	if __current_state:
		__current_state.physics_process(delta)


func change_to(next_state: String) -> void:
	if __states.get(next_state.to_lower()):
		if __current_state:
			__current_state.exit()
		
		__current_state = __states.get(next_state.to_lower())
		__current_state.enter()
		state_changed.emit(next_state)
	else:
		print_debug("Could not find state for: [%s]" % [next_state])


## Private Methods


func __add_states() -> void:
	for node in get_children():
		if node is BaseState:
			__states[node.name.to_lower()] = node
			node.next_state.connect(change_to)


func __enter_initial_state() -> void:
	if initial_state and __states.get(initial_state.name.to_lower()):
		__current_state = initial_state
	elif __states.size() > 0:
		__current_state = __states.values()[0]
	
	__current_state.enter()
