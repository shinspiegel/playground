class_name CutSceneActorMove extends CutSceneStepBase

@export var index: int = 0
@export var direction: Vector2 = Vector2.ZERO
@export_range(0.1, 5.0, 0.1) var duration: float = 0.5

@export_group("Animation", "animation_")
@export var animation_animate: bool = true
@export_enum("idle", "move") var animation_anim_name: String = "Move"

var last_anim: String


func execute() -> void:
	last_anim = PartyManager.at(index).get_anim()

	if animation_animate:
		CutSceneManager.animate_actor(CutSceneManager.at(index), animation_anim_name, direction.angle())

	CutSceneManager.move_actor(CutSceneManager.at(index), CutSceneManager.at(index).global_position + direction, duration)
	await CutSceneManager.moved

	if animation_animate:
		CutSceneManager.animate_actor(CutSceneManager.at(index), last_anim, direction.angle())

	ended.emit()
