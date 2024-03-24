class_name CutSceneAnim extends CutSceneTargetable

@export_enum("Zero", "Up", "Down", "Left", "Right") var direction: int = 0
@export_enum("idle", "move") var anim: String = "idle"

var dir: Vector2 = Vector2.ZERO


func execute() -> void:
	match direction:
		0: dir = Vector2.ZERO
		1: dir = Vector2.UP
		2: dir = Vector2.DOWN
		3: dir = Vector2.LEFT
		4: dir = Vector2.RIGHT
		_: dir = Vector2.ZERO

	actor.play_animation(anim, dir.angle())
	CutSceneManager.animate_actor(actor, anim, dir.angle())
	ended.emit()
