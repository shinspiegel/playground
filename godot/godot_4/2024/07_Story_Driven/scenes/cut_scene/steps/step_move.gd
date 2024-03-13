class_name CutSceneMove extends CutSceneTargetable

@export var direction: Vector2 = Vector2.ZERO
@export_range(0.1, 5.0, 0.1) var duration: float = 0.5

@export_group("Animation", "animation_")
@export var animation_animate: bool = true
@export_enum("idle", "move") var animation_anim_name: String = "Move"

var last_anim: String


func execute() -> void:
	last_anim = actor.get_anim()

	if animation_animate:
		actor.play_animation(animation_anim_name, direction.angle())

	CutSceneManager.move_actor(actor, actor.global_position + direction, duration)
	await CutSceneManager.moved

	if animation_animate:
		actor.play_animation(last_anim, direction.angle())

	ended.emit()
