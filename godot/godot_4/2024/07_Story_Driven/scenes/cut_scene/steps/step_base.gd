class_name CutSceneStepBase extends Resource

signal ended()


func execute() -> void:
	push_warning("super class, should implement specific steps")
	ended.emit()
