extends "res://Scripts/States/BASE_STATE.gd"

export (int) var DAMAGE := 1
export (int) var CHASE_SPEED := 30

onready var Timer = get_node("Timer")
onready var AttackArea = get_node("DamageArea")

var original_speed : int

func enter():
	Character.ANIM.play(name)
	original_speed = Character.SPEED
	Character.SPEED = CHASE_SPEED
	AttackArea.set_monitoring(true)
	return

func exit():
	Character.SPEED = original_speed
	AttackArea.set_monitoring(false)
	return

func state_update(delta):
	if Timer.is_stopped():
		Timer.start()
		if global_position.x < Character.INPUTS_HANDLER.Target.global_position.x:
			Character.INPUTS_HANDLER.set_direction(1)
		else:
			Character.INPUTS_HANDLER.set_direction(-1)
	
	Character.motion.x = Character.INPUTS_HANDLER.move_direction * Character.SPEED

func _on_DamageArea_body_entered(target):
	if target.has_method("receive_damage"):
		target.receive_damage(DAMAGE)
