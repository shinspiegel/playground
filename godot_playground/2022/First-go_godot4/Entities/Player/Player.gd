class_name Player extends CharacterBody2D

const BLOCK_SIZE = 16

@export var max_jump_height: float = BLOCK_SIZE * 5
@export var min_jump_height: float = BLOCK_SIZE * 1
@export var jump_time_to_peak: float = 0.3
@export var jump_time_to_descent: float = 0.25
@export var speed: float = BLOCK_SIZE * 8

@onready var jump_velocity: float = ((2.0 * max_jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * max_jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * max_jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1
@onready var coyoteTimer: Timer = $CoyoteTimer
@onready var stateManager: StateManager = $StateManager
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var input: PlayerInput = $PlayerInput

var can_jump: bool = true

func _ready():
	coyoteTimer.timeout.connect(on_timeout)
	stateManager.init()

func _physics_process(delta: float) -> void:
	stateManager.process(delta)
#	var direction = Input.get_axis("ui_left", "ui_right")
	
#	apply_coyote_time()
#	apply_gravity(delta)
#	apply_jump()
#	apply_horizontal()
	
	move_and_slide()

func apply_all(delta: float):
	apply_coyote_time()
	apply_gravity(delta)
	apply_jump()
	apply_horizontal()

func apply_horizontal() -> void:
	if input.direction:
		velocity.x = input.direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)


func apply_jump() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor() or can_jump:
			can_jump = false
			coyoteTimer.stop()
			velocity.y = jump_velocity
	
	if Input.is_action_just_released("ui_accept") and velocity.y < min_jump_height:
		velocity.y = min_jump_height


func apply_gravity(delta: float) -> void:
	if not is_on_floor() and not can_jump:
		var gravity = get_gravity()
		velocity.y += gravity * delta


func apply_coyote_time() -> void:
	if is_on_floor():
		can_jump = true
		coyoteTimer.stop()
	elif can_jump and coyoteTimer.is_stopped(): 
		coyoteTimer.start()


func get_gravity() -> float:
	if velocity.y < 0.0:
		return jump_gravity
	else:
		return fall_gravity


func on_timeout() -> void:
	can_jump = false
