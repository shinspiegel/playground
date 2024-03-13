class_name CutSceneBase extends Resource

signal ended()


func execute() -> void:
	push_warning("super class, should implement specific steps")
	ended.emit()

