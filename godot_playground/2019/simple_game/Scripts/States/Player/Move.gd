extends "res://Scripts/States/BASE_STATE.gd"

func enter():
	Character.ANIM.play(name)
	return

func state_update(delta):
	if Character.INPUTS_HANDLER.attack():
		Character.state_manager("Attack")
	if Character.INPUTS_HANDLER.jump():
		Character.state_manager("Jump")
	if Character.INPUTS_HANDLER.horizontal() == 0:
		Character.state_manager("Idle")
	
	Character.motion.x = Character.INPUTS_HANDLER.horizontal() * Character.SPEED
