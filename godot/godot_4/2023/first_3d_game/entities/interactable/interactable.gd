class_name Interactable extends Area3D

signal interacted()
signal focus()
signal blur()

@export var focused: bool = false

@onready var colddown: Timer = $Colddown

func interact() -> void:
	if colddown.time_left <= 0:
		interacted.emit()
		colddown.start()


func grab_focus() -> void:
	if not focused:
		focus.emit()
		focused = true


func drop_focus() -> void:
	focused = false
	blur.emit()
