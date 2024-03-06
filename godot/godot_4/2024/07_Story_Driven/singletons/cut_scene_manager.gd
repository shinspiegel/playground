extends Node2D

signal started()
signal ended()
signal step_finished()

@onready var wait_timer: Timer = $WaitTimer

var steps: Array[CutSceneStepBase] = []
var actors: Array[Actor] = []
var index: int = 0


func start(cut_scene_steps: Array[CutSceneStepBase], cut_scene_actors: Array[Actor] = []) -> void:
	index = 0
	steps = cut_scene_steps
	actors = cut_scene_actors

	for step in steps:
		step.ended.connect(on_step_end.bind(step))

	started.emit()
	steps[index].execute()


func animate_actor(actor: Actor, anim: String, angle: float) -> void:
	actor.play_animation(anim, angle)


func move_actor(actor: Actor, pos: Vector2, duration: float = 0.3, ease_type: Tween.EaseType = Tween.EASE_IN) -> void:
	var tw = create_tween().set_ease(ease_type)
	tw.tween_property(actor, "global_position", pos, duration)
	tw.play()


func next_step() -> void:
	index += 1

	if index < steps.size():
		steps[index].execute()
		return

	ended.emit()


func wait(seconds: float) -> Timer:
	wait_timer.start(seconds)
	return wait_timer


func on_step_end(step: CutSceneStepBase) -> void:
	step.ended.disconnect(on_step_end)
	step_finished.emit()
	next_step()

