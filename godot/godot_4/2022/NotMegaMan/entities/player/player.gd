class_name Player extends Character

@export var stats: PlayerData
@export var input: PlayerInput
@export var player_shoot: PackedScene
@export var camera_path: NodePath

@onready var coyote_timer: Timer = $Timers/CoyoteTimer
@onready var invencible_timer: Timer = $Timers/InvencibilityTimer
@onready var shot_colddown_timer: Timer = $Timers/ShotColdDown
@onready var jump_buffer_back_ray: RayCast2D = $Sensors/JumpBufferBack
@onready var jump_buffer_front_ray: RayCast2D = $Sensors/JumpBufferFront
@onready var remote_transform: RemoteTransform2D = $CameraArm/RemoteTransform2D
@onready var shoot_position: Marker2D = $Markers/ShootPosition



func _ready() -> void:
	if not hurt_box.hit_received.connect(on_receive_hit) == OK:
		print_debug("WARN:: Failed to connect hit_box")
	animation_player.play("Idle")
	SignalBus.player_hp_changed.emit(stats.hit_points, stats.max_hit_points)
	
	if not camera_path.is_empty():
		set_camera_on_remote(get_node(camera_path))

# Need to check the coyote time on this one
func _physics_process(delta: float) -> void:
	check_input()
	
	var was_on_ground: bool = false
	
	if is_on_floor():
		was_on_ground = true
		coyote_timer.stop()
	
	state_manager.apply_state(delta)
	check_flip()
	move_and_slide()
	
	if was_on_ground and not is_on_floor():
		coyote_timer.start()
	
	check_change_state()


func check_input() -> void:
	input.reset()
	
	if input.is_enabled:
		if Input.is_action_just_pressed(Constants.INPUT_KEYS.jump):
			input.jump = true
		
		if Input.is_action_just_pressed(Constants.INPUT_KEYS.attack):
			input.attack = true
		
		if Input.is_action_just_released(Constants.INPUT_KEYS.jump):
			input.jump_released = true
		
		input.direction = Input.get_axis(
			Constants.INPUT_KEYS.left,
			Constants.INPUT_KEYS.right
		)


func check_change_state() -> void:
	var current_state = state_manager.current_state.name
	var is_input_zero: bool = input.direction == 0.0
	var is_velocity_zero: bool = velocity.x == 0.0
	var is_jump_press: bool = input.jump
	var is_grounded: bool = is_on_floor() or coyote_timer.time_left > 0.0
	var is_falling: bool = velocity.y > 0
	var is_jump_buffer: bool = jump_buffer_back_ray.is_colliding() or jump_buffer_front_ray.is_colliding()
	var is_jump_released: bool = input.jump_released
	var is_attack: bool = input.attack
	var is_shot_colddown_zero: bool = shot_colddown_timer.time_left <= 0.0
	
	match str(state_manager.current_state.name):
		"Idle":
			if not is_input_zero:
				return change_state("Move")
			if is_jump_press and is_grounded:
				return change_state("Jump")
			if not is_grounded: 
				return change_state("Falling")
			if is_attack:
				return change_state("Attack")
		"Attack":
			if is_attack:
				state_manager.send_message("queue_shot")
			if not is_input_zero and is_shot_colddown_zero:
				return change_state("Move")
			if not is_input_zero and not is_shot_colddown_zero:
				return change_state("MoveAndShot")
		"MoveAndShot":
			if is_attack:
				state_manager.send_message("queue_shot")
			if not is_input_zero and is_shot_colddown_zero:
				return change_state("Move")
			if is_input_zero and not is_shot_colddown_zero:
				return change_state("Idle")
		"Move":
			if not is_grounded:
				return change_state("Falling")
			if is_jump_press and is_grounded:
				return change_state("Jump")
			if is_input_zero and is_velocity_zero:
				return change_state("Idle")
			if not is_input_zero and is_attack:
				return change_state("MoveAndShot")
		"JumpAndShot": 
			if is_attack:
				state_manager.send_message("queue_shot")
			if not is_input_zero and is_grounded:
				return change_state("Move")
			if is_input_zero and is_velocity_zero and is_grounded:
				return change_state("Idle")
		"Jump":
			if is_falling or is_jump_released:
				return change_state("Falling")
			if is_attack:
				return change_state("JumpAndShot")
		"Falling":
			if is_jump_buffer and is_jump_press:
				return change_state("Jump")
			if is_on_floor():
				return change_state("Idle")
			if is_attack:
				return change_state("JumpAndShot")


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


## Test if can spawn a shot, if is able, spawn it and return true, otherwise return false.
func spawn_shot() -> bool:
	if shot_colddown_timer.time_left <= 0.0:
		shot_colddown_timer.start()
		
		var shot: PlayerShot = player_shoot.instantiate()
		shot.global_position = shoot_position.global_position
		shot.diretion = flip.direction
		
		get_parent().add_child(shot)
		
		return true
	else:
		return false
