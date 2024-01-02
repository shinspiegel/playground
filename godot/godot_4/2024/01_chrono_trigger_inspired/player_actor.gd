class_name PlayerActor extends Actor

@export var game_state: GameState
@export var camera_mount: RemoteTransform2D
@export_range(0.1, 2.0, 0.1) var follow_ratio: float = 1.0
@export var distance: int = 120

var battle_ui: BattleUI
var camera: Camera2D
var leader: PlayerActor
var __last_dir: Vector2

func _ready() -> void:
	super._ready()
	leader = GameManager.get_leader()

	if is_leader():
		set_camera()


func _physics_process(delta: float) -> void:
	if game_state.is_world():
		if is_leader():
			__apply_user_input(delta)
		else:
			__follow_leader(delta)

	if game_state.is_battle():
		velocity = Vector2.ZERO

	move_and_slide()


func act_turn() -> void:
	battle_ui.show_command_for_actor(self)
	turn_started.emit()


func end_turn() -> void:
	battle_ui.hide_commands()
	turn_ended.emit()


func set_camera() -> void:
	camera_mount.set_remote_node(camera.get_path())


func clean_camera() -> void:
	camera_mount.set_remote_node("")


func is_leader() -> bool:
	return self == leader


# Private Methods


func __apply_user_input(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	direction.normalized()

	if not direction == Vector2.ZERO:
		__last_dir = direction

	if direction.is_zero_approx():
		velocity = lerp(velocity, Vector2.ZERO, friction)
	else:
		velocity = lerp(velocity, direction * move_speed * delta, friction)

	if direction.length() > 0.1:
		anim_move(__last_dir)
	else:
		anim_idle(__last_dir)


func __follow_leader(delta: float) -> void:
	var direction_to_leader = global_position.direction_to(leader.global_position)
	var distance_to_leader = global_position.distance_to(leader.global_position)

	if distance_to_leader > distance:
		var move_distance = move_speed * delta * follow_ratio
		velocity = lerp(velocity, direction_to_leader * move_distance, 0.1)
		anim_move(direction_to_leader)
	else:
		velocity = lerp(velocity, Vector2.ZERO, 0.9)
		anim_idle(direction_to_leader)


