class_name CutScenePlayerMove extends CutSceneStepBase

@export var index: int = 0
@export var direction: Vector2 = Vector2.ZERO
@export_range(0.1, 5.0, 0.1) var duration: float = 0.5


func execute() -> void:
	CutSceneManager.move_actor(PartyManager.party[index], PartyManager.party[index].global_position + direction, duration)
	ended.emit()
