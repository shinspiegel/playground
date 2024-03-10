class_name CutSceneActorAnim extends CutSceneStepBase

@export var index: int = 0
@export var direction: Vector2 = Vector2.ZERO
@export_enum("idle", "move") var anim: String = "idle"


func execute() -> void:
	CutSceneManager.animate_actor(CutSceneManager.at(index), anim, direction.angle())
	ended.emit()
