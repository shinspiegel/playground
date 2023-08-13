extends CharacterBody2D

const SPEED = 500.0

@export var game_camera: Camera2D

@onready var interactor: Interactor = $Interactor
@onready var camera_mount: RemoteTransform2D = $CameraMount


func _ready() -> void:
	camera_mount.remote_path = game_camera.get_path()


func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Input.is_action_just_pressed("ui_accept") and interactor.can_interact():
		interactor.interact_current()
	
	if Input.is_action_just_pressed("ui_cancel"):
		GameManager.open_inventory()
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()
