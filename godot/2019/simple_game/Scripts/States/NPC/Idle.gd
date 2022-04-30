extends "res://Scripts/States/BASE_STATE.gd"

func enter():
	Character.ANIM.play(name)
	return

func state_update(delta):
	Character.motion.x = 0
	return