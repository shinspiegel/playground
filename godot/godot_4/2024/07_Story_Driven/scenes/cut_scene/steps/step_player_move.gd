class_name CutScenePlayerMove extends CutSceneStepBase

@export var index: int = 0
@export var direction: Vector2 = Vector2.ZERO
@export_range(0.1, 5.0, 0.1) var duration: float = 0.5
@export_group("Animation", "animation_")
@export var animation_animate: bool = true
@export_enum("Idle", "Move") var animation_anim_name: String = "Idle"


func execute() -> void:
	if animation_animate:
		CutSceneManager.animate_actor(PartyManager.at(index), animation_anim_name, direction.angle())

	CutSceneManager.move_actor(PartyManager.at(index), PartyManager.at(index).global_position + direction, duration)
	await CutSceneManager.moved

	if animation_animate:
		CutSceneManager.animate_actor(PartyManager.at(index), animation_anim_name, direction.angle())

	ended.emit()
