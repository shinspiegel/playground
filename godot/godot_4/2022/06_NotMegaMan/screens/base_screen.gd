class_name BaseScreen extends Control

@export var initial_focus: NodePath

func _ready() -> void:
	if not initial_focus.is_empty():
		var focus = get_node(initial_focus)
		
		if focus is Control:
			focus.grab_focus()
