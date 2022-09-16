extends BaseState

func enter():
	.enter()
	character.motion.y = -(character.JUMP_FORCE / 2)

# warning-ignore:unused_argument
func on_animation_finished(animation: String):
	emit_signal("finished", "Idle")
