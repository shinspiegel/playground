class_name GameState extends Resource

enum STATES {WORLD, BATTLE, CUTSCENE}

@export var current_state: STATES = STATES.WORLD


func is_world() -> bool:
	return current_state == STATES.WORLD


func is_battle() -> bool:
	return current_state == STATES.BATTLE


func is_cutscene() -> bool:
	return current_state == STATES.CUTSCENE


func change_to_battle() -> void: change_state_to(STATES.BATTLE)
func change_to_world() -> void: change_state_to(STATES.WORLD)
func change_state_to(state: STATES) -> void:
	current_state = state
