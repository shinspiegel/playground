class_name Player extends CharacterBody3D

signal died

@export var move_speed: float = 250.0
@export var jump_force: float = 8.0
@export var gravity: float = 12.0
@export var jump_sfx: AudioStream
@export var death_sfx: AudioStream

@onready var model: MeshInstance3D = $CharacterVampire

var input: Vector2 = Vector2.ZERO
var jump: bool = false
var lert_weight: float = 0.3
var is_dead: bool = false


func _physics_process(delta: float) -> void:
	if not is_dead:
		_get_input()
		_update_facing_angle()
		_apply_movement(delta)


func _apply_movement(delta: float) -> void:
	velocity.x = input.x * move_speed * delta
	velocity.z = input.y * move_speed * delta
	
	if not is_on_floor():
		velocity.y -= gravity * delta

	if jump and is_on_floor():
		velocity.y = jump_force
		GameManager.play_sfx(jump_sfx)
	move_and_slide()


func _update_facing_angle() -> void:
	if input.length() > 0:
		model.rotation.y = lerp_angle(
			model.rotation.y,
			Vector2(input.y, input.x).angle(),
			lert_weight
		)


func _get_input() -> void:
	input = Vector2.ZERO
	jump = false
	input = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	if Input.is_action_pressed("jump"):
		jump = true


func die() -> void:
	if not is_dead:
		is_dead = true
		var audio = GameManager.play_sfx(death_sfx)
		audio.finished.connect(func(): died.emit())
