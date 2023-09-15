class_name Player extends CharacterBody2D

@export var camera: Camera2D
@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D

const SPEED = 6.0
const JUMP_VELOCITY = -8.0
const GRAVITY = 20.0
const MULTIPLIER = 100


func _ready() -> void:
	if camera:
		remote_transform_2d.remote_path = camera.get_path()


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta * MULTIPLIER
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY * MULTIPLIER
	
	var direction := Input.get_axis("ui_left", "ui_right")
	direction += 1
	
	if direction:
		velocity.x = direction * SPEED * MULTIPLIER
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
