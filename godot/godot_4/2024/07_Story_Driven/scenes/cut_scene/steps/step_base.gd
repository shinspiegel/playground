class_name CutSceneStep extends Resource

signal ended()

@export var wait_for_next: bool = true


func execute() -> void:
	push_warning("super class, should implement specific steps")
