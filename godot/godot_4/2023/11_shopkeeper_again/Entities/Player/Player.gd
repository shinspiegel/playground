class_name Player extends CharacterBody2D

@export var game_camera: Camera2D

@onready var interactor: Interactor = $Interactor
@onready var camera_mount: RemoteTransform2D = $CameraMount
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var effects: Node = $Effects

var __dir: Vector2 = Vector2.ZERO


func _ready() -> void:
	camera_mount.remote_path = game_camera.get_path()
	PlayerInput.options_pressed.connect(on_option_press)
	PlayerInput.action_pressed.connect(on_action_press)


func _physics_process(_delta: float) -> void:
	__update_dir()
	__apply_direction()
	__apply_animation()
	move_and_slide()


func on_option_press() -> void:
	GameManager.open_inventory()


func on_action_press(action: String) -> void:
	match action:
		PlayerInput.CROSS: __check_for_interaction()
		PlayerInput.SQUARE: PlayerData.use_hotbar_item(PlayerData.HOTBAR.ZERO, global_position)
		PlayerInput.TRIANGLE: PlayerData.use_hotbar_item(PlayerData.HOTBAR.ONE, global_position)
		PlayerInput.CIRCLE: PlayerData.use_hotbar_item(PlayerData.HOTBAR.TWO, global_position)


func __update_dir() -> void:
	__dir = PlayerInput.direction


func __apply_direction() -> void:
	if __dir: 
		velocity = __dir * PlayerData.stat_speed
	else: 
		velocity = velocity.move_toward(Vector2.ZERO, PlayerData.stat_speed)


func __apply_animation() -> void:
	animation_tree.set("parameters/blend_position", velocity.length())
	animation_tree.set("parameters/0/blend_position", PlayerInput.facing)
	animation_tree.set("parameters/1/blend_position", PlayerInput.facing)


func __check_for_interaction() -> void:
	if interactor.can_interact(): 
		interactor.interact_current()

