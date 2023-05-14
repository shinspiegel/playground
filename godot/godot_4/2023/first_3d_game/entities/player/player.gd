class_name Player extends CharacterBody3D

@export_range(0, 360, 15) var dir_rotation: int = 0

@onready var interactor: Interactor = $Interactor

const SPEED = 10.0
const GRAVITY: float = 9.8
var direction: Vector3 = Vector3.ZERO


func _ready() -> void:
	PlayerInput.interacted.connect(on_player_interact)


func _physics_process(delta: float) -> void:
	reset_direction()
	apply_gravity(delta)
	calculate_direction()
	apply_axis_rotation()
	apply_direction_to_velocity()
	move_and_slide()


func on_player_interact() -> void:
	interactor.interact_on_current()


func reset_direction() -> void:
	direction = Vector3.ZERO


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= GRAVITY * delta


func calculate_direction() -> void:
	var calculated: Vector3 = transform.basis * Vector3(PlayerInput.direction.x, 0, PlayerInput.direction.y)
	direction = calculated.normalized()


func apply_axis_rotation() -> void:
	direction = direction.rotated(Vector3(0,1,0), deg_to_rad(dir_rotation))


func apply_direction_to_velocity() -> void:
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
