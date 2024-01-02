class_name PlayerActor extends Actor

@export var char_name: String = ""
@export var game_state: GameState
@export var camera_mount: RemoteTransform2D
@export var is_active: bool = false

var battle_ui: BattleUI


var camera: Camera2D


func _ready() -> void:
	super._ready()

	if is_active:
		set_camera()


func _physics_process(delta: float) -> void:
	if is_active:
		__move_world(delta)

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


# Private Methods


func __move_world(delta: float) -> void:
	if game_state.is_world():
		var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		direction.normalized()

		if direction.is_zero_approx():
			velocity = lerp(velocity, Vector2.ZERO, friction)
		else:
			velocity = lerp(velocity, direction * move_speed * delta, friction)

	if game_state.is_battle():
		velocity = Vector2.ZERO

