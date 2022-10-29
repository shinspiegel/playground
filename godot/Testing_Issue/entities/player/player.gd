class_name Player extends Character

@export var stats: PlayerData
@export var input: PlayerInput

@onready var coyote_timer: Timer = $Timers/CoyoteTimer
@onready var invencible_timer: Timer = $Timers/InvencibilityTimer
@onready var jump_buffer_back_ray: RayCast2D = $Sensors/JumpBufferBack
@onready var jump_buffer_front_ray: RayCast2D = $Sensors/JumpBufferFront
@onready var remote_transform: RemoteTransform2D = $CameraTransform
@onready var hit_box: HitBox = $HitBox

func _ready() -> void:
	hurt_box.hit_received.connect(on_receive_hit)
	hit_box.disable()
	animation_player.play("Idle")
	SignalBus.player_hp_changed.emit(stats.hit_points, stats.max_hit_points)
	SignalBus.state_entered_for.emit(self, state_manager.current_state.name)


func check_input() -> void:
	input.reset()
	
	if input.is_enabled: 
		if Input.is_action_just_pressed(Constants.KEYS.jump):
			input.jump = true
		
		if Input.is_action_just_pressed(Constants.KEYS.attack):
			input.attack = true
		
		if Input.is_action_just_released(Constants.KEYS.jump):
			input.jump_released = true
		
		input.direction = Input.get_axis(
			Constants.KEYS.left,
			Constants.KEYS.right
		)


func check_change_state() -> void:
	var current_state = state_manager.current_state.name 
	var is_input_zero: bool = input.direction == 0.0
	var is_velocity_zero: bool = velocity.x == 0.0
	var is_jump_press: bool = input.jump
	var is_grounded: bool = is_on_floor()
	var is_falling: bool = velocity.y > 0
	var is_jump_buffer: bool = jump_buffer_back_ray.is_colliding() or jump_buffer_front_ray.is_colliding()
	var is_jump_released: bool = input.jump_released
	var is_attack: bool = input.attack
	
	if current_state == "Idle":
		if not is_input_zero:
			return change_state("Move")
		if is_jump_press and is_grounded:
			return change_state("Jump")
		if is_attack:
			return change_state("Attack")
	
	if current_state == "Move":
		if not is_grounded:
			return change_state("Falling")
		if is_jump_press and is_grounded:
			return change_state("Jump")
		if is_input_zero and is_velocity_zero:
			return change_state("Idle")
		if is_attack:
			return change_state("Attack")
	
	if current_state == "Jump":
		if is_falling or is_jump_released:
			return change_state("Falling")
		if not is_input_zero and is_grounded:
			return change_state("Move")
		if is_input_zero and is_velocity_zero and is_grounded:
			return change_state("Idle")
		if is_attack:
			return change_state("Attack")
	
	if current_state == "Falling":
		if not is_grounded and coyote_timer.time_left > 0.0 and is_jump_press:
			return change_state("Jump")
		if is_jump_buffer and is_jump_press:
			return change_state("Jump")
		if is_input_zero and is_grounded:
			return change_state("Idle")
		if not is_input_zero and is_grounded:
			return change_state("Move")
		if is_attack:
			return change_state("Attack")


func on_receive_hit(hit: HitBox) -> void:
	var is_inv_timeout = invencible_timer.time_left <= 0.0
	var is_not_hit = not state_manager.current_state.name == "Hit"
	
	if is_inv_timeout and is_not_hit:
		invencible_timer.start()
		stats.hurt(hit.damage.amount)
		SignalBus.player_hp_changed.emit(stats.hit_points, stats.max_hit_points)
		
		if stats.hit_points <= 0:
			change_state("Die")
		else:
			change_state("Hit")
			state_manager.send_message("hit", hit)


func set_camera_on_remote(camera: Camera2D) -> void:
	remote_transform.set_remote_node(camera.get_path())


func enable_attack_hit_box() -> void:
	hit_box.enable()


func disable_attack_hit_box() -> void:
	hit_box.disable()
