class_name WanderEnemy extends BaseEnemy

@export var shock_around_state: EnemyState

@onready var player_detector: PlayerDetector = $FlipEnabled/PlayerDetector
@onready var enter_shock_delay: Timer = $EnterShockDelay


func _ready() -> void:
	player_detector.player_sighted.connect(on_player_sight)
	player_detector.player_lost.connect(on_player_lost)
	enter_shock_delay.timeout.connect(on_shock_timeout)
	super._ready()


func on_player_sight() -> void:
	enter_shock_delay.start()


func on_player_lost() -> void:
	enter_shock_delay.stop()


func on_shock_timeout() -> void:
	state_machine.change_state(shock_around_state.name)
