extends Node

var entity

func enter(self_entity):
	entity = self_entity
	entity.anim.play("run")

func exit():
	entity.motion.x = 0

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
	
	if entity.inputs.horizontal() != 0:
		if entity.inputs.horizontal() > 0:
			entity.set_direction(1)
		else: 
			entity.set_direction(-1)
			
		entity.motion.x = entity.inputs.horizontal() * entity.SPEED
	else: 
		entity.state_manager("idle")
	
	if !entity.grounded():
		entity.state_manager("falling")




