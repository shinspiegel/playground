extends Node2D

@export var max_jump_height: float = 16*3
@export var min_jump_height: float = 16*1
@export var jump_time_to_peak: float = 0.3
@export var jump_time_to_descent: float = 0.25
@export var speed: float = 180

@onready var jump_velocity: float = ((2.0 * max_jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * max_jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * max_jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1


func apply_horizontal(motion: Vector2) -> Vector2:
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		motion.x = direction * speed
	else:
		motion.x = move_toward(motion.x, 0, speed)
	
	return motion


func apply_jump(motion: Vector2, is_on_ground: bool) -> Vector2:
	if Input.is_action_just_pressed("ui_accept") and is_on_ground:
		motion.y = jump_velocity
	
	if Input.is_action_just_released("ui_accept") and motion.y < min_jump_height:
		motion.y = min_jump_height
	
	return motion


func apply_gravity(motion: Vector2, delta: float, is_on_ground: bool) -> Vector2:
	if not is_on_ground:
		var gravity = get_gravity(motion)
		motion.y += gravity * delta
	
	return motion


func get_gravity(motion: Vector2) -> float:
	if motion.y < 0.0:
		return jump_gravity
	else:
		return fall_gravity

