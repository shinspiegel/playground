extends Node2D

signal started()
signal ended()
signal step_finished()

var steps: Array[CutSceneStep] = []
var index: int = 0


func start(cut_scene_steps: Array[CutSceneStep]) -> void:
	reset()
	steps = cut_scene_steps
	started.emit()
	execute_current()


func reset() -> void:
	index = 0
	steps.clear()


func execute_current() -> void:
	steps[index].execute()
	await steps[index].ended
	step_finished.emit()
	next_step()


func next_step() -> void:
	index += 1

	if index < steps.size():
		execute_current()
		return

	ended.emit()
