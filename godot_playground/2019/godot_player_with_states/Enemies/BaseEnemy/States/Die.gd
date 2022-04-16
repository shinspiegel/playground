extends Node

var entity

func enter(self_entity):
	entity = self_entity
	entity.anim.play("idle")

func exit():
	pass

func animation_finished(anim_name):
	pass

func update():
	entity.queue_free()