class_name Interactable extends Area3D

signal interacted()
signal focus()
signal blur()

@export var focused: bool = false

func interact() -> void:
	interacted.emit()


func grab_focus() -> void:
	if not focused:
		focus.emit()
		focused = true


func drop_focus() -> void:
	focused = false
	blur.emit()
