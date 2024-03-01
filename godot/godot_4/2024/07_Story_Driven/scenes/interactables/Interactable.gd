class_name Interactable extends Area2D

signal interacted()
signal focus()
signal blur()

var is_focused: bool = false


func grab_focus() -> void:
	if not is_focused:
		is_focused = true
		focus.emit()


func release_focus() -> void:
	if is_focused:
		is_focused = false
		blur.emit()
