extends Node

var entity

func enter(self_entity):
	entity = self_entity
	entity.anim.play("falling")

func exit():
	pass

func animation_finished(anim_name):
	pass

func update():
	entity.handle_gravity(1.3)
	handle_horizontal()
	
	if entity.is_on_floor():
		entity.state_manager("idle")

func handle_horizontal():
	if entity.inputs.horizontal() != 0:
		if entity.inputs.horizontal() > 0:
			entity.set_direction(1)
		else: 
			entity.set_direction(-1)
			
	entity.motion.x = entity.inputs.horizontal() * entity.SPEED