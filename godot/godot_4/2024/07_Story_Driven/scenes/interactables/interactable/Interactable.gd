class_name Interactable extends Area2D

@export var active: bool = true

@warning_ignore("unused_signal")
signal interacted()
signal focus()
signal blur()

var is_focused: bool = false


func grab_focus() -> void:
	if not is_focused and active:
		is_focused = true
		focus.emit()


func release_focus() -> void:
	if is_focused and active:
		is_focused = false
		blur.emit()
