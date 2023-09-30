class_name Player extends CharacterBody2D

signal collided_with_wall

@export var camera: Camera2D

@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D
@onready var damage_receiver: Area2D = $DamageReceiver
@onready var damage_number_pos: Marker2D = $DamageNumberPos
@onready var wall_detection: Area2D = $WallDetection
@onready var front: Marker2D = $WeaponsAttachment/Front
@onready var top: Marker2D = $WeaponsAttachment/Top
@onready var back: Marker2D = $WeaponsAttachment/Back


func _ready() -> void:
	__setup_camera()
	__setup_damage_receiver()
	__setup_power_ups()


func _physics_process(delta: float) -> void:
	__apply_gravity(delta)
	__apply_jump()
	__check_for_walls()
	move_and_slide()


func on_damage_receive(damage: Damage) -> void:
	PlayerData.deal_damage(damage.amount)
	GameManager.spawn_damage_at(damage, damage_number_pos.global_position)
	GameManager.invoque_shake(damage.shake)


func set_camera(cam: Camera2D) -> void:
	remote_transform_2d.remote_path = cam.get_path()


func __apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GameManager.GRAVITY * GameManager.MULTIPLIER * delta


func __apply_jump() -> void:
	if Input.is_action_just_pressed(PlayerData.JUMP_KEY) and is_on_floor():
		velocity.y = PlayerData.get_player_jump_velocity()
	
	if Input.is_action_just_released(PlayerData.JUMP_KEY) and velocity.y <= 0:
		velocity.y = 0


func __check_for_walls() -> void:
	for col in wall_detection.get_overlapping_bodies():
		if col is TileMap:
			collided_with_wall.emit()


func __setup_camera() -> void:
	if camera:
		remote_transform_2d.remote_path = camera.get_path()


func __setup_damage_receiver() -> void:
	damage_receiver.receive_damage.connect(on_damage_receive)


func __setup_power_ups() -> void:
	for power_up in PlayerData.get_power_up_list():
		if power_up.is_selected:
			if power_up.extra_weapon: 
				__add_weapon_to_slot(power_up.extra_weapon, power_up.extra_weapon_slot)


func __add_weapon_to_slot(scene: PackedScene, slot: String) -> void:
	var slot_to_attach = __get_slot_by_string(slot)
	
	if not slot_to_attach:
		print_debug("WARN:: failed to locate slot to attach power up")
		return
	
	var node: Node = scene.instantiate()
	slot_to_attach.add_child(node)


func __get_slot_by_string(slot: String) -> Marker2D:
	match slot:
		"front": return front
		"top": return top
		"back": return back
		_: return null
