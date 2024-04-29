extends EnemyState

@export var idle_duration: Timer
@export var next_state: EnemyState


func enter() -> void:
	connect_damage_hit()
	play_anim()

	if idle_duration:
		idle_duration.timeout.connect(on_idle_end)
		idle_duration.start()


func exit() -> void:
	disconnect_damage_hit()

	if idle_duration:
		idle_duration.timeout.disconnect(on_idle_end)


func update(delta: float) -> void:
	enemy.apply_gravity(delta)
	enemy.apply_direction(0, enemy.data.friction_land, 0.9)
	enemy.move_and_slide()
	enemy.check_flip(enemy.direction)


func on_idle_end() -> void:
	if next_state:
		state_machine.change_by_state(next_state)
	else:
		state_machine.change_initial()

