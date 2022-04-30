extends "res://Scripts/Character.gd"

var motion = Vector2()

func _physics_process(delta):
	update_motion(delta)
	move_and_slide(motion)

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		LightSwitch()

func update_motion(delta):
	look_at(get_global_mouse_position())
	
	var vertical = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	var horizontal = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	motion.y += vertical * SPEED
	motion.x += horizontal * SPEED
	
	if abs(motion.y) >= MAX_SPEED:
		if motion.y > 0:
			motion.y  = MAX_SPEED
		if motion.y < 0:
			motion.y = -MAX_SPEED
	
	if abs(motion.x) >= MAX_SPEED:
		if motion.x > 0:
			motion.x = MAX_SPEED
		if motion.x < 0:
			motion.x = -MAX_SPEED
	
	if abs(vertical) <= 0.1:
		motion.y = lerp(motion.y, 0, FRICTION)
	if abs(horizontal) <= 0.1:
		motion.x = lerp(motion.x, 0, FRICTION)

func LightSwitch():
	var Light = get_node("Light2D")
	if Light == null:
		return
	Light.set_enabled(!Light.is_enabled())