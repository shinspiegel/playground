extends Node

export (int) var JUMP_POWER : int = 70
export (int) var air_time : int = 5

var entity
var jumping : bool = false
var held : int = 0

func enter(self_entity):
	held = air_time
	entity = self_entity
	jumping = false
	entity.anim.play("jump")

func exit():
	held = air_time
	jumping = false

func animation_finished(anim_name):
	pass

func update():
	entity.handle_gravity()
	handle_jump()
	handle_horizontal()

func handle_jump():
	if entity.inputs.is_jump_pressed() && held > 0 && !jumping:
		held -= 1
		entity.motion.y -= JUMP_POWER
	
	if entity.inputs.is_jump_release():
		held = air_time
		jumping = true
	
	if entity.motion.y > 0:
		entity.state_manager("falling")
	
	if entity.is_on_floor() && !jumping:
		entity.state_manager("idle")

func handle_horizontal():
	if entity.inputs.horizontal() != 0:
		if entity.inputs.horizontal() > 0:
			entity.set_direction(1)
		else: 
			entity.set_direction(-1)
			
	entity.motion.x = entity.inputs.horizontal() * entity.SPEED