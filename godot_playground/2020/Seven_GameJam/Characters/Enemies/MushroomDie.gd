extends "res://Characters/State/Die.gd"

func enter():
	.enter()
	character.hit_box_area.set_disabled(true)
