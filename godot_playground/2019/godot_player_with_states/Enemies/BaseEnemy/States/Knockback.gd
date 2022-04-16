extends Node

var entity

func enter(self_entity):
	entity = self_entity
	entity.anim.play("idle")
	color_modulate_red(true)

func exit():
	pass

func animation_finished(anim_name):
	pass

func update():
	pass

func color_modulate_red(value : bool) -> void:
	if value:
		entity.set_modulate(Color(0.5, 0, 0, 1))
	else:
		entity.set_modulate(Color(1, 1, 1, 1))