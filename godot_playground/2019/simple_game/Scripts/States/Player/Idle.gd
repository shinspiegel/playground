extends "res://Scripts/States/BASE_STATE.gd"


func enter():
	Character.ANIM.play(name)
	Character.motion.x = 0
	Character.motion.y = 0
	return

func state_update(delta):
	if Character.INPUTS_HANDLER.horizontal() != 0:
		Character.state_manager("Move")
	if Character.INPUTS_HANDLER.jump() == true:
		Character.state_manager("Jump")
	if Character.INPUTS_HANDLER.attack():
		Character.state_manager("Attack")
