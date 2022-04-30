extends Node

var entity
var knockback : int = 0
var max_knockback : int = 5

func enter(self_entity):
	entity = self_entity
	entity.anim.play("knockback")
	color_modulate_red(true)
	knockback = max_knockback
	entity.motion.x = 0
	entity.motion.y = 0

func exit():
	knockback = max_knockback
	color_modulate_red(false)

func animation_finished(anim_nam1e):
	pass

func update():
	entity.handle_gravity()
	if knockback > 0:
		knockback -= 1
		entity.motion.x = -(50 * entity.direction)
		entity.motion.y = -50
	else: 
		entity.state_manager("idle")

func color_modulate_red(value : bool) -> void:
	if value:
		entity.set_modulate(Color(0.5, 0, 0, 1))
	else:
		entity.set_modulate(Color(1, 1, 1, 1))