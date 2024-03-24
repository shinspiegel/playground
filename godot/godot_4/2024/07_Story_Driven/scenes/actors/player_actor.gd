class_name PlayerActor extends Actor

@export var camera: Camera2D
@export var follow_side: int = 0

@onready var camera_holder: RemoteTransform2D = %CameraHolder
@onready var interactor: Interactor = $Interactor

var is_user_controlled: bool = false
var last_dir: Vector2 = Vector2.ZERO
var is_force_move: bool = false
var leader: Actor = null


func _ready() -> void:
	apply_textures_from_data()
	play_idle()

	if not camera: push_error("missing camera node")
	if is_user_controlled:
		enable_camera()
		interactor.is_active = true
	else:
		leader = PartyManager.get_leader()
		interactor.is_active = false



func _physics_process(delta: float) -> void:
	if GameManager.is_world():
		if is_user_controlled:
			__check_interactor()
			__move_player()
			__apply_animation()
		else:
			__move_towards_player(delta)
			__apply_animation()

		move_and_slide()


func enable_camera() -> void:
	camera_holder.remote_path = camera.get_path()


func disable_camera() -> void:
	camera_holder.remote_path = ""


func __move_player() -> void:
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	input_dir.normalized()

	if not input_dir == Vector2.ZERO:
		last_dir = input_dir
		velocity = input_dir * actor_data.speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, actor_data.speed * actor_data.friction)


func __apply_animation() -> void:
	if not velocity == Vector2.ZERO:
		play_move(last_dir)
	else:
		play_idle(last_dir)


func __move_towards_player(delta: float) -> void:
	var distance_to_leader = global_position.distance_to(leader.global_position)

	if distance_to_leader > actor_data.follow_max_distance:
		is_force_move = true

	if is_force_move:
		__teleport_to_leader()
	else:
		__follow_leader(delta)


func __follow_leader(delta: float) -> void:
	var direction_to_leader = global_position.direction_to(leader.global_position)
	var distance_to_leader = global_position.distance_to(leader.global_position)
	var offset_direction = direction_to_leader.rotated(deg_to_rad(actor_data.follow_angle) * follow_side).normalized() * actor_data.follow_distance
	var target_position = leader.global_position + offset_direction

	direction_to_leader = global_position.direction_to(target_position)
	distance_to_leader = global_position.distance_to(target_position)
	last_dir = direction_to_leader

	if distance_to_leader > actor_data.follow_min_distance:
		velocity = direction_to_leader.normalized() * actor_data.speed * actor_data.follow_ratio
	else:
		velocity = velocity.move_toward(Vector2.ZERO, actor_data.speed * actor_data.friction * delta)


func __teleport_to_leader() -> void:
	var tw = create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(self, "global_position", leader.global_position, actor_data.follow_force_duration)
	await tw.finished
	is_force_move = false


func __check_interactor() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		interactor.interact()
