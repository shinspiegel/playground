extends BaseState

func enter():
	.enter()
	character.hurtBoxCollider.set_disabled(true)
	
	if character.get("hitboxCollision") != null:
		character.hitboxCollision.set_disabled(true)


# warning-ignore:unused_argument
func update_state(delta : float):
	character.motion = Vector2.ZERO
	character.input_vector = Vector2.ZERO


# warning-ignore:unused_argument
func on_animation_finished(animation: String):
	character.queue_free()
