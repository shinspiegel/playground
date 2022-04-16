extends "res://Scripts/States/BASE_STATE.gd"

func enter():
	Character.ANIM.play(name)
	Character.motion.y = -150
	return

func state_update(delta):
	Character.motion.x = 0
	return

func animation_finished():
	if Character.current_state.name == "Hurt":
		Character.state_manager(Character.last_state)
