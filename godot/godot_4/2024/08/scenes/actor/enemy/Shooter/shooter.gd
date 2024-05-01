extends BaseEnemy

@export var shoot_delay: Timer
@export var shoot_state: EnemyState

@onready var player_detector: PlayerDetector = %PlayerDetector


func _ready() -> void:
	super._ready()

	player_detector.player_sighted.connect(on_player_sight)
	player_detector.player_lost.connect(on_player_lost)
	shoot_delay.timeout.connect(on_shoot_timeout)


func _physics_process(delta: float) -> void:
	super._physics_process(delta)

	if player_detector.has_player():
		turn_to(player_detector.get_player().global_position)

		if shoot_delay.is_stopped() and not state_machine.is_on_state(shoot_state):
			shoot_delay.start()


func on_player_sight() -> void:
	shoot_delay.start()


func on_player_lost() -> void:
	shoot_delay.stop()


func on_shoot_timeout() -> void:
	state_machine.change_by_state(shoot_state)
