class_name CutScenePartyAnim extends CutSceneStep

@export var direction: Vector2 = Vector2.ZERO
@export_enum("idle", "mode") var anim: String = "idle"


func execute() -> void:
	for member in PartyManager.party:
		member.play_animation(anim, direction.angle())

	ended.emit()
