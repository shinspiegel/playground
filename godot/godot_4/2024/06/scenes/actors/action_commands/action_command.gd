class_name ActionCommand extends Resource

signal finished

@export var name: String


func act() -> void:
	push_warning("not implemented act")
	finished.emit()

