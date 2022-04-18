class_name Player extends CharacterBody2D

@export var max_jump_height: float = Const.PIXEL_BLOCK * 3
@export var min_jump_height: float = Const.PIXEL_BLOCK * 1
@export var jump_time_to_peak: float = 0.3
@export var jump_time_to_descent: float = 0.25
@export var speed: float = 180

@onready var jump_velocity: float = ((2.0 * max_jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * max_jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * max_jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1

@onready var coyoteTimer: Timer = $CoyoteTime

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	apply_jump()
	apply_horizontal()
	
	move_and_slide()


func apply_horizontal() -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)


func apply_jump() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor() or coyoteTimer.time_left >= 0:
			velocity.y = jump_velocity
			coyoteTimer.stop()
	
	if Input.is_action_just_released("ui_accept") and velocity.y < min_jump_height:
		velocity.y = min_jump_height
		coyoteTimer.stop()


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		var gravity = get_gravity()
		velocity.y += gravity * delta
		coyoteTimer.start()


func get_gravity() -> float:
	if velocity.y < 0.0:
		return jump_gravity
	else:
		return fall_gravity
