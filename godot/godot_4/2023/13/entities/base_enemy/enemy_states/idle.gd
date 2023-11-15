extends BaseState

@export var enemy: BaseEnemy
@export var idle_colddown: Timer
@export var animation_player: AnimationPlayer
@export var player_detector: PlayerDetector

@export_group("State Change", "next_")
@export var next_idle_timeout: BaseState
@export var next_player_detection: BaseState



func enter() -> void:
	animation_player.play(name)
	idle_colddown.start()
	enemy.velocity = Vector2.ZERO
	idle_colddown.timeout.connect(on_time_out)
	player_detector.player_sighted.connect(on_player_sight)


func exit() -> void:
	idle_colddown.timeout.disconnect(on_time_out)
	player_detector.player_sighted.disconnect(on_player_sight)


func on_time_out() -> void:
	state_ended.emit(next_idle_timeout.name)


func on_player_sight() -> void:
	state_ended.emit(next_player_detection.name)
