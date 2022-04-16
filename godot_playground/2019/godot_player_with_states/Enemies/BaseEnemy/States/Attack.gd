extends Node

var entity

func enter(self_entity):
	entity = self_entity
	entity.anim.play("attack")

func exit():
	pass

func animation_finished(anim_name):
	pass

func update():
	pass