class_name CutSceneAnim extends CutSceneTargetable

@export var direction: Vector2 = Vector2.ZERO
@export_enum("idle", "move") var anim: String = "idle"


func execute() -> void:
	actor.play_animation(anim, direction.angle())
	CutSceneManager.animate_actor(actor, anim, direction.angle())
	ended.emit()
