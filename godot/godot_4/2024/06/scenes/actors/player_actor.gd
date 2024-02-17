class_name PlayerActor extends Actor

@export var camera: Camera2D

@onready var camera_holder: RemoteTransform2D = %CameraHolder

var __last_dir := Vector2.ZERO


func _ready() -> void:
	apply_textures_from_data()

	if not camera: push_error("missing camera node")
	enable_camera()


func _physics_process(delta: float) -> void:
	if not Engine.is_editor_hint() and GameManager.is_world():
		__move_player(delta)
		__apply_animation()
		move_and_slide()


func enable_camera() -> void:
	camera_holder.remote_path = camera.get_path()


func disable_camera() -> void:
	camera_holder.remote_path = ""


func __move_player(delta: float) -> void:
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	input_dir.normalized()

	if not input_dir == Vector2.ZERO:
		__last_dir = input_dir
		velocity = input_dir * actor_data.speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, actor_data.speed * delta * actor_data.friction)


func __apply_animation() -> void:
	if not velocity == Vector2.ZERO:
		play_move(__last_dir)
	else:
		play_idle(__last_dir)


