class_name Player extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const FACING_LERP = 0.3
const GRAVITY = 9.8

@export var camera_path: NodePath
@onready var input: PlayerInput = $PlayerInput
@onready var remote_transform_3d: RemoteTransform3D = $RemoteTransform3D
@onready var model: Node3D = $Model
@onready var hurt_box: Area3D = $HurtBox

var game_camera: Camera3D

func _ready() -> void:
	game_camera = get_node(camera_path)
	remote_transform_3d.remote_path = game_camera.get_path()


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	apply_jump()
	apply_direction()
	apply_model_facing_diretion()
	
	move_and_slide()


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= GRAVITY * delta


func apply_direction() -> void:
	var direction := input.get_direction(transform.basis)
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


func apply_jump() -> void:
	if input.has_jump() and is_on_floor():
		velocity.y = JUMP_VELOCITY


func apply_model_facing_diretion() -> void:
	if input.get_direction(transform.basis).length() > 0:
		var input_angle := Vector2(input.get_input().y, input.get_input().x).angle()
		model.rotation.y = lerp_angle(model.rotation.y, input_angle,FACING_LERP)
