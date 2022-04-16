extends Node

var entity

func enter(self_entity):
	entity = self_entity
	entity.anim.play("idle")
	entity.motion.x = 0

func exit():
	pass

func animation_finished(anim_name):
	pass

func update():
	entity.handle_gravity()
	
	if entity.inputs.is_jump_pressed():
		entity.state_manager("jump")
	elif entity.inputs.is_attack_pressed():
		entity.state_manager("sword")
	elif entity.inputs.is_bow_pressed():
		entity.state_manager("bow")
	elif entity.inputs.horizontal() != 0:
		entity.state_manager("run")