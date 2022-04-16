extends BaseState

func _enter_state():
	print("Entered Idle")

func get_user_actions():
	entity.INPUT.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	entity.INPUT.y = Input.get_action_strength("ui_up")


func apply_horizontal_force():
	entity.MOTION.x = entity.INPUT.x * entity.SPEED


func apply_jump_power():
	if Input.get_action_strength("ui_up"):
		if entity.is_on_floor():
			entity.MOTION.y = -abs(entity.JUMP_FORCE)


func apply_gravity(delta: float):
	entity.MOTION.y += CONSTANTS.GRAVITY * delta
	entity.MOTION.y = min(entity.MOTION.y, entity.JUMP_FORCE)
