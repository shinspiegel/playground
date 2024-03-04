extends Node2D

signal started()
signal ended()
signal step_finished()

@onready var wait_timer: Timer = $WaitTimer

var steps: Array[CutSceneStep] = []
var index: int = 0


func start(cut_scene_steps: Array[CutSceneStep]) -> void:
	reset()
	steps = cut_scene_steps

	for step in steps:
		step.ended.connect(on_step_end.bind(step))

	started.emit()
	steps[index].execute()


func reset() -> void:
	index = 0
	steps = []


func next_step() -> void:
	index += 1

	if index < steps.size():
		steps[index].execute()
		return

	ended.emit()


func wait(seconds: float) -> Timer:
	wait_timer.start(seconds)
	return wait_timer


func on_step_end(step: CutSceneStep) -> void:
	step.ended.disconnect(on_step_end)
	step_finished.emit()
	next_step()

