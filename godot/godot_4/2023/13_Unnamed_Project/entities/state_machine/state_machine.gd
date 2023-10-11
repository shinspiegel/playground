extends Node2D

@export var actor: Node2D
@export var initial_state: BaseState

var __current_state: BaseState


func change_state(new_state: BaseState) -> void:
	if __current_state:
		__current_state.exit()
	
	__current_state = new_state
	__current_state.enter()


func process_physics(delta: float) -> void:
	var new_state = __current_state.process_physics(delta)
	
	if new_state:
		change_state(new_state)


func process_input(event: InputEvent) -> void:
	var new_state = __current_state.process_input(event)
	
	if new_state:
		change_state(new_state)


func process_frame(delta: float) -> void:
	var new_state = __current_state.process_frame(delta)
	
	if new_state:
		change_state(new_state)
