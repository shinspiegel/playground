extends Node2D

signal started()
signal ended()
signal step_finished()
signal moved()

@onready var wait_timer: Timer = $WaitTimer

var data: CutSceneData
var actors: Array[Actor] = []
var index: int = 0


func start(scene_data: CutSceneData, cut_scene_actors: Array[Actor] = []) -> void:
	index = 0
	data = scene_data
	actors = cut_scene_actors

	for step in scene_data.steps:
		step.ended.connect(on_step_end.bind(step))

	started.emit()
	data.steps[index].execute()


func animate_actor(actor: Actor, anim: String, angle: float) -> void:
	actor.play_animation(anim, angle)


func move_actor(actor: Actor, pos: Vector2, duration: float = 0.3, ease_type: Tween.EaseType = Tween.EASE_IN) -> void:
	if duration > 0:
		var tw = create_tween().set_ease(ease_type)
		tw.tween_property(actor, "global_position", pos, duration)
		tw.play()
		await tw.finished
	else:
		actor.global_position = pos
	
	moved.emit()


func next_step() -> void:
	index += 1

	if index < data.size():
		data.steps[index].execute()
		return

	ended.emit()


func wait(seconds: float) -> Timer:
	wait_timer.start(seconds)
	return wait_timer


func on_step_end(step: CutSceneStepBase) -> void:
	step.ended.disconnect(on_step_end)
	step_finished.emit()
	next_step()

