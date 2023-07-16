class_name Player extends CharacterBody3D

const MOVE = {
	SPEED = 5.0,
	JUMP_VELOCITY = 4.5,
	FACING_LERP = 0.3,
	GRAVITY = 9.8,
}

const ANIM = {
	IDLE = "idle",
	MOVE = "move",
}

@export var game_camera: Node3D
@export var anim_player: AnimationPlayer
@onready var input: PlayerInput = $PlayerInput
@onready var remote_transform_3d: RemoteTransform3D = $RemoteTransform3D
@onready var model: Node3D = $Model
@onready var hurt_box: Area3D = $HurtBox
@onready var state_manager: StateManager = $StateManager


var direction: Vector3 = Vector3.ZERO

func _ready() -> void:
	remote_transform_3d.remote_path = game_camera.get_path()
	state_manager.state_changed.connect(func(s): SignalBus.player_state_change.emit(s))
	state_manager.state_entered.connect(func(s): SignalBus.player_state_change.emit(s))


func _physics_process(delta: float) -> void:
	update_direction()
	state_manager.apply_current_state(delta)
	move_and_slide()
	
	check_state_change()


func update_direction() -> void:
	direction = input.get_direction(transform.basis)


func check_state_change() -> void:
	if direction:
		state_manager.change_state("Move")
	else:
		state_manager.change_state("Idle")


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= MOVE.GRAVITY * delta


func apply_direction() -> void:
	if direction:
		velocity.x = direction.x * MOVE.SPEED
		velocity.z = direction.z * MOVE.SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, MOVE.SPEED)
		velocity.z = move_toward(velocity.z, 0, MOVE.SPEED)


func apply_model_facing_diretion() -> void:
	if input.get_direction(transform.basis).length() > 0:
		var input_angle := Vector2(input.get_input().y, input.get_input().x).angle()
		model.rotation.y = lerp_angle(model.rotation.y, input_angle, MOVE.FACING_LERP)


func anim_play(animation: String) -> void: anim_player.play(animation)
func anim_play_idle() -> void: anim_play(ANIM.IDLE)
func anim_play_move() -> void: anim_play(ANIM.MOVE)
