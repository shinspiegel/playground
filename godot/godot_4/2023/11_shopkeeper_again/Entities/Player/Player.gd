extends CharacterBody2D

const SPEED = 500.0

@export var game_camera: Camera2D

@onready var interactor: Interactor = $Interactor
@onready var camera_mount: RemoteTransform2D = $CameraMount


func _ready() -> void:
	camera_mount.remote_path = game_camera.get_path()
	PlayerInput.options_pressed.connect(func(): GameManager.open_inventory())


func _physics_process(_delta: float) -> void:
	var direction := PlayerInput.direction
	
	if PlayerInput.cross and interactor.can_interact():
		interactor.interact_current()
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()
