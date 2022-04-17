class_name StateManager extends Node2D

@export var initial_state: NodePath

var state_list = {}
var current_state: BaseState = null


func _ready():
	for node in get_children():
		if node is BaseState:
			state_list[node.name] = node
	
	var initial = get_node(initial_state)
	change_state(initial.name)


func _physics_process(delta):
	if not current_state == null:
		current_state.update(delta);


func change_state(state_name: String) -> void:
	if state_name in state_list:
		current_state = state_list[state_name]


