extends BaseEnemyState

@export var player_detector: PlayerDetector

@export_group("Chase", "chase_")
@export_range(0.0, 5.0, 0.1) var chase_speed_override: float = 1.0

@export_group("Foil", "foil_")
@export var foil_timer: Timer
@export var foil_next_state: BaseState

var __last_player_pos: Vector2 = Vector2.ZERO
var __should_update_pos: bool = true
@export var debug_marker: Node2D


func enter() -> void:
	play_animation()

	player_detector.player_sighted.connect(on_player_sighted)
	player_detector.player_lost.connect(on_player_lost_sight)
	foil_timer.timeout.connect(on_timeout)


func exit() -> void:
	inputs.reset()
	__last_player_pos = Vector2.ZERO


func physics_process(delta: float) -> void:
	__update_last_position()
	__update_input_direction()

	enemy.apply_gravity(delta)
	enemy.apply_horizontal_force(0.2, chase_speed_override)
	enemy.move_and_slide()



func on_player_lost_sight() -> void:
	__should_update_pos = false
	foil_timer.start()


func on_player_sighted() -> void:
	__should_update_pos = true
	foil_timer.stop()


func on_timeout() -> void:
	state_ended.emit(foil_next_state.name)


## Private Methods


func __update_last_position() -> void:
	if __should_update_pos:
		var last_pos = player_detector.get_player_global_position()
		if last_pos is Vector2:
			__last_player_pos = last_pos

		debug_marker.global_position = __last_player_pos # DEL_ME


func __update_input_direction() -> void:
	inputs.direction = __last_player_pos.x - enemy.global_position.x
