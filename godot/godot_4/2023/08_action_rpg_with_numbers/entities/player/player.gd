class_name Player extends CharacterBody3D

const MOVE = { SPEED = 5.0, JUMP_VELOCITY = 4.5, FACING_LERP = 0.3, GRAVITY = 9.8, }
const ANIM = { RESET= "RESET", IDLE = "idle", MOVE = "move", SWING_LEFT = "swing_left", SWING_RIGHT = "swing_right" }
const STATES = { IDLE = "Idle", MOVE = "Move", ATTACK = "Attack", }

@export var game_camera: Node3D
@export var anim_player: AnimationPlayer

@onready var input: PlayerInput = $PlayerInput
@onready var remote_transform_3d: RemoteTransform3D = $RemoteTransform3D
@onready var model: Node3D = $Model
@onready var hurt_box: Area3D = $HurtBox
@onready var state_manager: StateManager = $StateManager


func _ready() -> void:
	remote_transform_3d.remote_path = game_camera.get_path()
	state_manager.state_changed.connect(func(s): SignalBus.player_state_change.emit(s))
	state_manager.state_entered.connect(func(s): SignalBus.player_state_change.emit(s))
	anim_player.animation_finished.connect(on_animation_finished)


func _physics_process(delta: float) -> void:
	state_manager.apply_current_state(delta)
	move_and_slide()
	
	check_state_change()


func check_state_change() -> void:
	if state_manager.get_current_state_name() == STATES.ATTACK: 
		return
	
	if input.attack_left or input.attack_right: 
		state_manager.change_state(STATES.ATTACK)
		if input.attack_left: anim_play(ANIM.SWING_LEFT)
		if input.attack_right: anim_play(ANIM.SWING_RIGHT)
		return
	
	if input.get_direction(): 
		return state_manager.change_state(STATES.MOVE)
	
	return state_manager.change_state(STATES.IDLE)


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= MOVE.GRAVITY * delta


func apply_direction() -> void:
	if input.get_direction():
		velocity.x = input.get_direction().x * MOVE.SPEED
		velocity.z = input.get_direction().z * MOVE.SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, MOVE.SPEED)
		velocity.z = move_toward(velocity.z, 0, MOVE.SPEED)


func apply_model_facing_diretion() -> void:
	if input.get_direction().length() > 0:
		var input_angle := Vector2(input.get_input().y, input.get_input().x).angle()
		model.rotation.y = lerp_angle(model.rotation.y, input_angle, MOVE.FACING_LERP)


func on_animation_finished(anim: String) -> void:
	if anim == ANIM.SWING_LEFT or anim == ANIM.SWING_RIGHT:
		state_manager.change_state(STATES.IDLE)


func anim_play(animation: String) -> void: 
	anim_player.play(animation)
