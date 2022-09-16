extends Node2D
onready var Character := get_owner()

func enter():
	Character.ANIM.play(name)
	return

func exit():
	return

func state_update(delta):
	return

func animation_finished():
	return
