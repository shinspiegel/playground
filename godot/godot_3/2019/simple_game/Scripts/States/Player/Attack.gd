extends "res://Scripts/States/BASE_STATE.gd"

export (int) var DAMAGE := 1

onready var AttackArea := get_node("AttackArea")

func enter():
	Character.ANIM.play(name)
	return

func exit():
	AttackArea.set_monitoring(false)
	return

func state_update(delta):
	Character.motion.x = lerp(Character.motion.x, 0, 0.05)
	if Character.ANIM.get_frame() == 5:
		AttackArea.set_monitoring(true)

func animation_finished():
	if Character.current_state.name == "Attack":
		Character.state_manager(Character.last_state)

func _on_AttackArea_body_entered(target):
	if target.has_method("receive_damage"):
		target.receive_damage(DAMAGE)
