class_name StateManager extends Node2D

@export var initial_state: NodePath
@export var player_path: NodePath

var state_list = {}
var current_state: BaseState
var player: Player


func init() -> void:
	_set_player()
	_get_all_nodes()
	_set_initial_state()


func process(delta:float) -> void:
	if not current_state == null:
		current_state.process(delta)
		current_state.check_for_new_state(delta)


func change_state(state: String) -> void:
	if state_list.has(state):
		if not current_state == null:
			current_state.exit()
		
		current_state = state_list[state]
		current_state.enter()


func _get_all_nodes():
	for node in get_children():
		if node is BaseState:
			node.stateManager = self
			
			if not player == null:
				node.player = player
			
			state_list[node.name] = node


func _set_player():
	if not player_path == null:
		player = get_node(player_path)


func _set_initial_state():
	if not initial_state == null:
		var initial = get_node(initial_state)
		change_state(initial.name)
