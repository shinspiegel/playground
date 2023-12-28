class_name PlayerActor extends Actor

@export var game_state: GameState
@export var camera: Camera2D
@export var battle_ui: BattleUI

@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D


func _physics_process(delta: float) -> void:
	__move_world(delta)
	move_and_slide()


func act_turn() -> void:
	battle_ui.show_command_for_actor(self)


func end_turn() -> void:
	battle_ui.hide_commands()
	turn_ended.emit()


func __move_world(delta: float) -> void:
	if game_state.is_world():
		var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		direction.normalized()

		if direction.is_zero_approx():
			velocity = lerp(velocity, Vector2.ZERO, friction)
		else:
			velocity = lerp(velocity, direction * speed * delta, friction)

	if game_state.is_battle():
		velocity = Vector2.ZERO


func set_camera() -> void:
	remote_transform_2d.set_remote_node(camera.get_path())


func clean_camera() -> void:
	remote_transform_2d.set_remote_node("")
