class_name CutSceneActorSetPos extends CutSceneStepBase

@export var index: int = 0
@export var position: Vector2 = Vector2.ZERO
@export_range(0.1, 5.0, 0.1) var duration: float = 0.5


func execute() -> void:
	CutSceneManager.move_actor(CutSceneManager.actors[index], position, duration)
	ended.emit()
