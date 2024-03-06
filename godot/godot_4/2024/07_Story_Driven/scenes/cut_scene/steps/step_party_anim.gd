class_name CutScenePartyAnim extends CutSceneStepBase

@export var direction: Vector2 = Vector2.ZERO
@export_enum("idle", "mode") var anim: String = "idle"


func execute() -> void:
	for member in PartyManager.party:
		CutSceneManager.animate_actor(member, anim, direction.angle())

	ended.emit()
