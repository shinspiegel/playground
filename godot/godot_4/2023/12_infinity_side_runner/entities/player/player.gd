class_name Player extends CharacterBody2D

signal collided_with_wall

const JUMP_KEY = "ui_accept"

@export var camera: Camera2D
@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D
@onready var damage_receiver: Area2D = $DamageReceiver
@onready var damage_number_pos: Marker2D = $DamageNumberPos
@onready var wall_detection: Area2D = $WallDetection


func _ready() -> void:
	if camera:
		remote_transform_2d.remote_path = camera.get_path()
	damage_receiver.receive_damage.connect(on_damage_receive)


func _physics_process(delta: float) -> void:
	__apply_gravity(delta)
	__apply_jump()
	__check_for_walls()
	move_and_slide()


func on_damage_receive(damage: Damage) -> void:
	PlayerData.deal_damage(damage.amount)
	GameManager.spawn_damage_at(damage, damage_number_pos.global_position)
	GameManager.invoque_shake(damage.shake)


func __apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GameManager.GRAVITY * delta * GameManager.MULTIPLIER


func __apply_jump() -> void:
	if Input.is_action_just_pressed(JUMP_KEY) and is_on_floor():
		velocity.y = GameManager.JUMP_VELOCITY * GameManager.MULTIPLIER * -1
	
	if Input.is_action_just_released(JUMP_KEY) and velocity.y <= 0:
		velocity.y = 0


func __check_for_walls() -> void:
	for col in wall_detection.get_overlapping_bodies():
		if col is TileMap:
			collided_with_wall.emit()
