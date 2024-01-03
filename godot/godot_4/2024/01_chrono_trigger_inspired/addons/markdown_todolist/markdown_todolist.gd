@tool
extends EditorPlugin

var dock

func _enter_tree() -> void:
	dock = preload("res://addons/markdown_todolist/dock_scene.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_RIGHT_BL, dock)


func _exit_tree() -> void:
	remove_control_from_docks(dock)
	dock.free()
