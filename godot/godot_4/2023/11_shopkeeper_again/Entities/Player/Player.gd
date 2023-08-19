extends CharacterBody2D

const SPEED = 500.0

@export var game_camera: Camera2D

@onready var interactor: Interactor = $Interactor
@onready var camera_mount: RemoteTransform2D = $CameraMount

var __direction: Vector2 = Vector2.ZERO


func _ready() -> void:
	camera_mount.remote_path = game_camera.get_path()
	PlayerInput.options_pressed.connect(func(): GameManager.open_inventory())
	PlayerInput.action_pressed.connect(on_action_press)


func _physics_process(_delta: float) -> void:
	__apply_direction()
	__apply_interaction()
	move_and_slide()


func __apply_direction() -> void:
	__direction = PlayerInput.direction
	
	if __direction: velocity = __direction * SPEED
	else: velocity = velocity.move_toward(Vector2.ZERO, SPEED)


func __apply_interaction() -> void:
	if PlayerInput.cross and interactor.can_interact():
		interactor.interact_current()


func on_action_press(action: String) -> void:
	match action:
		PlayerInput.SQUARE: print_debug("Square")
		PlayerInput.TRIANGLE: print_debug("Triangle")
		PlayerInput.CIRCLE: print_debug("Circle")
