class_name Player extends KinematicBody2D

const BLOCK_SIZE = 16

export(Resource) var stats
export(float) var max_jump_height: float = BLOCK_SIZE * 3
export(float) var min_jump_height: float = BLOCK_SIZE * 2
export(float) var jump_time_to_peak: float = 0.45
export(float) var jump_time_to_descent: float = 0.35
export(float) var speed: float = BLOCK_SIZE * 10

onready var jump_velocity: float = ((2.0 * max_jump_height) / jump_time_to_peak) * -1
onready var jump_gravity: float = ((-2.0 * max_jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
onready var fall_gravity: float = ((-2.0 * max_jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1
onready var coyoteTimer: Timer = $CoyoteTimer
onready var input: PlayerInput = $PlayerInput
onready var label: Label = $Label

var can_jump: bool = true
var flip_direction: int = 1
var velocity = Vector2.ZERO


func _ready() -> void:
	setup_camera()
	setup_player_stats()
	setup_coyote_timer()


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed(KeysMap.PAUSE_GAME):
		stats.hurt(1)
		Manager.screen.open_pause_menu()

	apply_all(delta)

	apply_flip_scale()
	velocity = move_and_slide(velocity, Vector2.UP)


func apply_flip_scale():
	var value = velocity.x

	if value != 0:
		if value > 0 and flip_direction == -1:
			scale.x *= -1
			flip_direction = 1
		if value < 0 and flip_direction == 1:
			scale.x *= -1
			flip_direction = -1


func apply_all(delta: float) -> void:
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


func on_coyote_timeout() -> void:
	can_jump = false


func on_health_changed(value: int, _min_value: int, max_value: int) -> void:
	label.text = String(value) + "/" + String(max_value)


func setup_camera() -> void:
	var camera = Camera2D.new()
	camera.clear_current()
	camera.make_current()
	add_child(camera)


func setup_player_stats() -> void:
	var con = stats.hit_points_resource.connect("changed_detailed", self, "on_health_changed")
	if con != OK:
		print_debug("INFO:: Failed to connect")

	if stats.hit_points == 0:
		stats.hit_points_resource.set_to_max()

	stats.hit_points_resource.emit_signals()


func setup_coyote_timer() -> void:
	var con = coyoteTimer.connect("timeout", self, "on_coyote_timeout")
	if not con == OK:
		print_debug("INFO:: Failed to connect")
