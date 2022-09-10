extends CharacterBody2D

const BLOCK_SIZE = 16
const JUMP_VELOCITY = -400.0
const SPEED: float = BLOCK_SIZE * 10.0
const MAX_JUMP_HEIGHT: float = BLOCK_SIZE * 3
const MIN_JUMP_HEIGHT: float = BLOCK_SIZE * 2
const JUMP_TIME_TO_PEAK: float = 0.45
const JUMP_TIME_TO_DESCENT: float = 0.35

@export var stats: Resource

@onready var jump_power: float = ((2.0 * MAX_JUMP_HEIGHT) / JUMP_TIME_TO_PEAK) * -1
@onready var jump_gravity: float = ((-2.0 * MAX_JUMP_HEIGHT) / (JUMP_TIME_TO_PEAK * JUMP_TIME_TO_PEAK)) * -1
@onready var fall_gravity: float = ((-2.0 * MAX_JUMP_HEIGHT) / (JUMP_TIME_TO_DESCENT * JUMP_TIME_TO_DESCENT)) * -1
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_manager: StateManager = $StateManager
@onready var hurt_box: HurtBox = $HurtBox
@onready var coyote_timer: Timer = $Timers/CoyoteTimer
@onready var invencible_timer: Timer = $Timers/InvencibleTimer
@onready var jump_buffer_ray: RayCast2D = $Sensor/JumpBuffer


var flip = { "is_active": true, "direction": 1 }
var input = { "direction": 0.0, "jump": false }


func _ready() -> void:
	hurt_box.hit_received.connect(on_receive_hit)
	animation_player.play("Idle")
	await get_tree().root.ready
	SignalBus.player_hp_changed.emit(stats.hit_points, stats.max_hit_points)
	SignalBus.state_entered_for.emit(self, state_manager.current_state.name)


func _physics_process(delta: float) -> void:
	check_input()
	
	state_manager.apply(delta)
	
	check_flip()
	check_change_state()
	
	move_and_slide()


func apply_horizontal(direction: float, speed: float = SPEED, ratio: float = 1.0 ) -> void:
	if not direction == 0.0:
		velocity.x = direction * (speed * ratio)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * ratio)


func apply_vertical(power: float, ratio: float = 1.0) -> void:
	velocity.y = (abs(power) * -1) * ratio


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += get_gravity() * delta


func get_gravity() -> float:
	if velocity.y < 0.0:
		return jump_gravity
	else:
		return fall_gravity


func check_change_state() -> void:
	var is_input_zero: bool = input.direction == 0.0
	var is_velocity_zero: bool = velocity.x == 0.0
	var is_jump_press: bool = input.jump
	var is_grounded: bool = is_on_floor()
	var is_falling: bool = velocity.y > 0
	var is_jump_buffer: bool = jump_buffer_ray.is_colliding()
	
	if state_manager.current_state.name == "Idle":
		if not is_input_zero:
			return change_state("Move")
		if is_jump_press and is_grounded:
			return change_state("Jump")
	
	if state_manager.current_state.name == "Move":
		if not is_grounded:
			return change_state("Falling")
		if is_jump_press and is_grounded:
			return change_state("Jump")
		if is_input_zero and is_velocity_zero:
			return change_state("Idle")
	
	if state_manager.current_state.name == "Jump":
		if is_falling:
			return change_state("Falling")
		if not is_input_zero and is_grounded:
			return change_state("Move")
		if is_input_zero and is_velocity_zero and is_grounded:
			return change_state("Idle")
	
	if state_manager.current_state.name == "Falling":
		if not is_grounded and coyote_timer.time_left > 0.0 and is_jump_press:
			return change_state("Jump")
		if is_jump_buffer and is_jump_press:
			return change_state("Jump")
		if is_input_zero and is_grounded:
			return change_state("Idle")
		if not is_input_zero and is_grounded:
			return change_state("Move")


func change_state(state: String) -> void:
	state_manager.change_state(state)


func change_animation(anim: String) -> void:
	if not animation_player == null:
		if animation_player.has_animation(anim) and not animation_player.current_animation == anim:
			animation_player.play(anim)


func check_flip() -> void:
	if flip.is_active:
		var value = velocity.x
	
		if value != 0:
			if value > 0 and flip.direction == -1:
				scale.x *= -1
				flip.direction = 1
			if value < 0 and flip.direction == 1:
				scale.x *= -1
				flip.direction = -1


func check_input() -> void:
	input.diretion = 0.0
	input.jump = false
	
	if Input.is_action_just_pressed(Constants.KEYS.jump):
		input.jump = true
	
	input.direction = Input.get_axis(
		Constants.KEYS.left,
		Constants.KEYS.right
	)


func on_receive_hit(hit: HitBox):
	var is_inv_timeout = invencible_timer.time_left <= 0.0
	var is_not_hit = not state_manager.current_state.name == "Hit"
	
	if is_inv_timeout and is_not_hit:
		invencible_timer.start()
		stats.hurt(hit.damage.amount)
		SignalBus.player_hp_changed.emit(stats.hit_points, stats.max_hit_points)
		change_state("Hit")
		state_manager.send_message("hit", hit)
