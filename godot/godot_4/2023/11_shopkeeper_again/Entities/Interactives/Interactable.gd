class_name Interactable extends Area2D

signal interacted()
signal focus()
signal blur()


func interact() -> void:
	interacted.emit()


func grab_focus() -> void:
	focus.emit()


func release_focus() -> void:
	blur.emit()
