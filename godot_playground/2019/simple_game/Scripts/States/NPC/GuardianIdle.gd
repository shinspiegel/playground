extends "res://Scripts/States/BASE_STATE.gd"

onready var Timer := get_node("Timer")

func enter():
	Character.ANIM.play(name)
	Timer.start()
	return

func state_update(delta):
	Character.motion.x = 0
	
	if Timer.is_stopped():
		Character.state_manager("Watch")
	return