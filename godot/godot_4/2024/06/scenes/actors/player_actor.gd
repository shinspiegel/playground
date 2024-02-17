class_name PlayerActor extends Actor

@export var camera: Camera2D
@export var follow_side: int = 0

@onready var camera_holder: RemoteTransform2D = %CameraHolder

var is_user_controlled: bool = false
var last_dir := Vector2.ZERO


func _ready() -> void:
	apply_textures_from_data()

	if not camera: push_error("missing camera node")
	if is_user_controlled: enable_camera()


func _physics_process(delta: float) -> void:
	if GameManager.is_world():
		if is_user_controlled:
			__move_player(delta)
			__apply_animation()
		else:
			__follow_leader(delta)

		move_and_slide()


func enable_camera() -> void:
	camera_holder.remote_path = camera.get_path()


func disable_camera() -> void:
	camera_holder.remote_path = ""


func __move_player(delta: float) -> void:
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	input_dir.normalized()

	if not input_dir == Vector2.ZERO:
		last_dir = input_dir
		velocity = input_dir * actor_data.speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, actor_data.speed * delta * actor_data.friction)


func __apply_animation() -> void:
	if not velocity == Vector2.ZERO:
		play_move(last_dir)
	else:
		play_idle(last_dir)


func __follow_leader(delta: float) -> void:
	var leader = PartyManager.get_leader()
	var direction_to_leader = global_position.direction_to(leader.global_position)
	var distance_to_leader = global_position.distance_to(leader.global_position)

	var offset_direction = direction_to_leader.rotated(deg_to_rad(actor_data.follow_angle) * follow_side).normalized() * actor_data.follow_distance
	var target_position = leader.global_position + offset_direction

	direction_to_leader = global_position.direction_to(target_position)
	distance_to_leader = global_position.distance_to(target_position)

	if distance_to_leader > actor_data.follow_min_distance:
		velocity = velocity.move_toward(
			direction_to_leader.normalized() * actor_data.speed * actor_data.follow_ratio,
			actor_data.friction
		)
		play_move(direction_to_leader)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, actor_data.speed * delta * actor_data.friction)
		play_idle(direction_to_leader)

