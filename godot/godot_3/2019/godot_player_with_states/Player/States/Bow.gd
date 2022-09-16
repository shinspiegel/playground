extends Node

var entity
var is_shooting : bool = false

export (PackedScene) var Arrow

func enter(self_entity):
	entity = self_entity
	is_shooting = true
	entity.anim.play("bow")

func exit():
	is_shooting = false

func animation_finished(anim_name):
	spawn_arrow()
	is_shooting = false
	entity.state_manager("idle")

func update():
	entity.motion.x = 0
	
	if !is_shooting:
		entity.state_manager("idle")

func spawn_arrow():
	var new_arrow = Arrow.instance()
	new_arrow.position = entity.get_global_position()
	new_arrow.set_direction(entity.direction)
	entity.get_parent().add_child(new_arrow)