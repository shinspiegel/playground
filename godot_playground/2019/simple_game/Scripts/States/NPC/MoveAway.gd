extends "res://Scripts/States/BASE_STATE.gd"

export (int) var JUMP_POWER := 300

onready var BackSight := get_node("BackSight")
onready var Timer := get_node("Timer")
onready var WallAhead := get_node("WallAhead")

func enter():
	Character.ANIM.play(name)
	Timer.start()
	find_direction()
	Character.motion.x = Character.INPUTS_HANDLER.move_direction * Character.SPEED

func exit():
	Character.INPUTS_HANDLER.change_direction()
	Character.motion.x = Character.INPUTS_HANDLER.move_direction
	return

func state_update(delta):
	Character.motion.x = Character.INPUTS_HANDLER.move_direction * Character.SPEED	
	
	if WallAhead.is_colliding() && Character.is_on_floor():
		Character.motion.y -= JUMP_POWER
		
	if Timer.is_stopped() && !BackSight.is_colliding():
		Character.state_manager("Idle")

func animation_finished():
	return

func find_direction():
	var target_pos : Vector2 = Character.INPUTS_HANDLER.Target.get_global_position()
	var char_pos : Vector2 = Character.get_global_position()
	
	if char_pos.x > target_pos.x:
		Character.INPUTS_HANDLER.set_direction(1)
	else:
		Character.INPUTS_HANDLER.set_direction(-1)