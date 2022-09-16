extends "res://Scripts/States/BASE_STATE.gd"

export (int) var JUMP_POWER : int = 350
var is_jumping : bool

func enter():
	Character.ANIM.play(name)
	Character.motion.y -= JUMP_POWER
	is_jumping = true
	return

func exit():
	is_jumping = false
	return

func animation_finished():
	if Character.ANIM.get_animation() == "Jump":
		Character.ANIM.stop()

func state_update(delta):
	if Character.is_on_floor():
		Character.state_manager("Idle")
	else:
		if Character.INPUTS_HANDLER.attack():
			Character.state_manager("Attack")
	
	Character.motion.x = Character.INPUTS_HANDLER.horizontal() * Character.SPEED
