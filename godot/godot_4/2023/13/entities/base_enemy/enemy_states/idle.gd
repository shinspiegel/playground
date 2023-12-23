extends BaseState

@export var enemy: BaseEnemy
@export var animation_player: AnimationPlayer
@export var player_detector: PlayerDetector
@export var anim_name: String = ""

@export_group("Idle Config", "idle_")
@export var idle_colddown: Timer
@export var idle_next_state_timeout: BaseState
@export var idle_next_state_player_sighted: BaseState


func enter() -> void:
	if anim_name.is_empty():
		animation_player.play(name)
	else:
		animation_player.play(anim_name)

	idle_colddown.start()
	enemy.velocity = Vector2.ZERO
	idle_colddown.timeout.connect(on_time_out)

	if not player_detector == null:
		player_detector.player_sighted.connect(on_player_sight)


func exit() -> void:
	idle_colddown.timeout.disconnect(on_time_out)

	if not PlayerDetector == null:
		player_detector.player_sighted.disconnect(on_player_sight)


func on_time_out() -> void:
	state_ended.emit(idle_next_state_timeout.name)


func on_player_sight() -> void:
	state_ended.emit(idle_next_state_player_sighted.name)
