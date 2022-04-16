extends "res://Scripts/States/BASE_STATE.gd"

onready var ground_ahead := get_node("ground_ahead")
onready var wall_ahead := get_node("wall_ahead")


func enter():
	Character.ANIM.play(name)
	if Character.get_modulate() != Color(1,1,1,1):
		Character.set_modulate(Color(1,1,1,1))
	return

func state_update(delta):
	should_turn()
	Character.motion.x = Character.INPUTS_HANDLER.move_direction * Character.SPEED

func should_turn():
	if !ground_ahead.is_colliding() || wall_ahead.is_colliding():
		Character.INPUTS_HANDLER.change_direction()
