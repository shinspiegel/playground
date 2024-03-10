class_name CutSceneData extends Resource

@export var steps: Array[CutSceneStepBase] = []


func size() -> int:
	return steps.size()


func at(index: int) -> CutSceneStepBase:
	return steps[index]


func execute_at(index: int) -> void:
	at(index).execute()
