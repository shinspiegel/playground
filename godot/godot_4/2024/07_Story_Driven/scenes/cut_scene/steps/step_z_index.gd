class_name CutSceneZIndex extends CutSceneTargetable

@export var z_index: int = 0


func execute() -> void:
	actor.z_index = z_index
	ended.emit()
