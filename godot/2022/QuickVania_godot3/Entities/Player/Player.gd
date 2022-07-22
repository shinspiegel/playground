class_name Player extends KinematicBody2D

const BLOCK_SIZE = 16

export(Resource) var stats
export(Resource) var power_ups
export(float) var max_jump_height: float = BLOCK_SIZE * 3
export(float) var min_jump_height: float = BLOCK_SIZE * 2
export(float) var jump_time_to_peak: float = 0.45
export(float) var jump_time_to_descent: float = 0.35
export(float) var speed: float = BLOCK_SIZE * 10
export var flip_direction: int = 1
export var velocity = Vector2.ZERO
export var is_flip_active = true

onready var jump_velocity: float = ((2.0 * max_jump_height) / jump_time_to_peak) * -1
onready var jump_gravity: float = ((-2.0 * max_jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
onready var fall_gravity: float = ((-2.0 * max_jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1
onready var state_manager: StateManager = $StateManager
onready var coyote_timer: Timer = $Timers/CoyoteTimer
onready var charge_attack_timer: Timer = $Timers/ChargeAttackTimer
onready var dash_coldown: Timer = $Timers/DashColdown
onready var input: PlayerInput = $PlayerInput
onready var label: Label = $Label
onready var state_label: Label = $StateLabel
onready var ground_front: RayCast2D = $GroundSensor/GroundFront
onready var ground_back: RayCast2D = $GroundSensor/GroundBack
onready var jump_buffer: RayCast2D = $GroundSensor/JumpBuffer
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var hurt_box: HurtBox = $HurtBox
onready var message_pos: Position2D = $MessagePos
onready var text_to_voice: TextToVoice = $TextToVoice


func _ready() -> void:
	setup_player_stats()
	setup_state_manager()
	setup_hurt_box()


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed(KeysMap.PAUSE_GAME):
		text_to_voice.play_string("Something", 2)
		speak("Something")
		pass

	state_manager.apply(delta)

	check_reset_powerups()
	apply_flip_scale()
	velocity = move_and_slide(velocity, Vector2.UP)


func apply_flip_scale():
	if is_flip_active:
		var value = velocity.x

		if value != 0:
			if value > 0 and flip_direction == -1:
				scale.x *= -1
				flip_direction = 1
			if value < 0 and flip_direction == 1:
				scale.x *= -1
				flip_direction = -1


func apply_horizontal(ratio: float = 1.0, override_input = null) -> void:
	var dir = input.direction

	if not override_input == null:
		dir = override_input

	if not dir == 0.0:
		velocity.x = dir * (speed * ratio)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * ratio)


func apply_jump() -> void:
	if input.jump_press:
		if is_on_floor():
			velocity.y = jump_velocity

	if input.jump_release and velocity.y < min_jump_height:
		velocity.y = min_jump_height


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += get_gravity() * delta


func get_gravity() -> float:
	if velocity.y < 0.0:
		return jump_gravity
	else:
		return fall_gravity


func add_camera(top: int, bottom: int, left: int, right: int) -> void:
	var camera = Camera2D.new()

	camera.clear_current()
	camera.make_current()

	camera.set_limit(MARGIN_TOP, top)
	camera.set_limit(MARGIN_BOTTOM, bottom)
	camera.set_limit(MARGIN_LEFT, left)
	camera.set_limit(MARGIN_RIGHT, right)

	add_child(camera)


func change_state(state: String) -> void:
	state_manager.change_state(state)


func change_animation(anim: String) -> void:
	if not animation_player == null and animation_player.has_animation(anim):
		animation_player.play(anim)


func is_jump_buffer() -> bool:
	if jump_buffer.is_colliding():
		return true
	return false


func check_reset_powerups() -> void:
	if power_ups.is_dash_used:
		if is_on_floor() and dash_coldown.time_left <= 0:
			power_ups.is_dash_used = false

	if power_ups.is_doulbe_jump_used:
		if is_on_floor():
			power_ups.is_doulbe_jump_used = false


func speak(message: String) -> void:
	Manager.bubble.display_message_at(message, message_pos.global_position)


## Attempt to change state methods


func attempt_to_idle() -> bool:
	if is_on_floor() and input.direction == 0.0:
		change_state("Idle")
		return true
	return false


func attempt_to_move() -> bool:
	if is_on_floor() and not input.direction == 0.0:
		change_state("Move")
		return true
	return false


func attempt_to_fall() -> bool:
	if not is_on_floor():
		change_state("Falling")
		return true
	return false


func attempt_to_attack() -> bool:
	if is_on_floor() and input.attack:
		change_state("Attack")
		return true
	return false


func attempt_to_charge_attack() -> bool:
	if is_on_floor() and input.charge_attack and power_ups.is_charge_attack_active:
		change_state("ChargingAttack")
		return true
	return false


func attempt_to_jump() -> bool:
	var is_grounded = is_on_floor() or coyote_timer.time_left > 0
	var is_jump_buffed = not is_on_floor() and is_jump_buffer()

	if (is_grounded or is_jump_buffed) and input.jump_press:
		change_state("Jump")
		return true
	return false


func attempt_to_double_jump() -> bool:
	if power_ups.is_double_jump_active and input.jump_press and not power_ups.is_doulbe_jump_used:
		change_state("DoubleJump")
		return true
	return false


func attempt_to_dash() -> bool:
	if input.dash and power_ups.is_dash_active and not power_ups.is_dash_used:
		change_state("Dash")
		return true
	return false


## OVERRIDE CLASS METHODS


func is_on_floor() -> bool:
	if ground_front.is_colliding() or ground_back.is_colliding():
		return true
	return false


## SIGNAL METHODS


func on_health_changed(value: int, _min_value: int, max_value: int) -> void:
	label.text = String(value) + "/" + String(max_value)


func on_state_change(new_state: String) -> void:
	state_label.text = new_state


func on_receive_hit(_hit_box: HitBox) -> void:
	change_state("Hit")


## SETUP METHODS


func setup_player_stats() -> void:
	var con = stats.hit_points_resource.connect("changed_detailed", self, "on_health_changed")
	if not con == OK:
		print_debug("INFO:: Failed to connect [%s]" % [stats.hit_points_resource.name])

	if stats.hit_points == 0:
		stats.hit_points_resource.set_to_max()

	stats.hit_points_resource.emit_signals()


func setup_state_manager() -> void:
	var con = state_manager.connect("state_entered", self, "on_state_change")
	if not con == OK:
		print_debug("INFO:: Failed to connect [%s]" % [state_manager.name])


func setup_hurt_box() -> void:
	var con = hurt_box.connect("hit_received", self, "on_receive_hit")
	if not con == OK:
		print_debug("INFO:: Failed to connect [%s]" % [hurt_box.name])
