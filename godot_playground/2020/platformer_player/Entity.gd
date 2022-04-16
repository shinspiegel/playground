class_name Entity
extends KinematicBody2D

export (int) var SPEED = 120
export (int) var JUMP_FORCE = 120

var INPUT = Vector2.ZERO
var MOTION = Vector2.ZERO

onready var stateManager = get_node("StateManager")

func _physics_process(delta):
	stateManager._apply_current_state(delta)
	
#	get_user_actions()
#	apply_horizontal_force()
#	apply_jump_power()
#	apply_gravity(delta)
#
#	MOTION = move_and_slide(MOTION, Vector2.UP)
#
#
#func get_user_actions():
#	INPUT.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#	INPUT.y = Input.get_action_strength("ui_up")
#
#
#func apply_horizontal_force():
#	MOTION.x = INPUT.x * SPEED
#
#
#func apply_jump_power():
#	if Input.get_action_strength("ui_up"):
#		if is_on_floor():
#			MOTION.y = -abs(JUMP_FORCE)
#
#
#func apply_gravity(delta: float):
#	MOTION.y += CONSTANTS.GRAVITY * delta
#	MOTION.y = min(MOTION.y, JUMP_FORCE)
