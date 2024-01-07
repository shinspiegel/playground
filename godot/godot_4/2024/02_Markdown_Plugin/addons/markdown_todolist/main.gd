@tool extends EditorPlugin

var dock


func _enter_tree():
	dock = preload("res://addons/markdown_todolist/markdown_todos.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_RIGHT_BL, dock)

func _exit_tree():
	remove_control_from_docks(dock)
	dock.free()
