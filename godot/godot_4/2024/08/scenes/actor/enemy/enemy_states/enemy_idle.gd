extends EnemyState

@export var idle_duration: Timer
@export var next_state: EnemyState
@export var damage_receiver: DamageReceiver


func enter() -> void:
	idle_duration.timeout.connect(on_idle_end)
	damage_receiver.receive_damage.connect(enemy.on_receive_damage)
	play_anim()
	idle_duration.start()


func exit() -> void:
	idle_duration.timeout.disconnect(on_idle_end)
	damage_receiver.receive_damage.disconnect(enemy.on_receive_damage)


func update(delta: float) -> void:
	enemy.apply_gravity(delta)
	enemy.apply_direction(0, enemy.data.friction_land, 0.9)
	enemy.move_and_slide()
	enemy.check_flip(enemy.direction)


func on_idle_end() -> void:
	state_machine.change_by_state(next_state)


