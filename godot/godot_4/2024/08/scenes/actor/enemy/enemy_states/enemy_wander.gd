extends EnemyState

@export var floor_raycast: RayCast2D
@export var wall_raycast: RayCast2D
@export var next_state: EnemyState
@export var delay_timer: Timer


func enter() -> void:
	delay_timer.start()

	play_anim()
	connect_damage_hit()

	if not floor_raycast.is_colliding() or wall_raycast.is_colliding():
		enemy.direction *= -1


func exit() -> void:
	disconnect_damage_hit()


func update(delta: float) -> void:
	enemy.apply_gravity(delta)
	enemy.apply_direction(enemy.direction, enemy.data.friction_land, 0.9)
	enemy.move_and_slide()
	enemy.check_flip(enemy.direction)

	if wall_raycast.is_colliding():
		enemy.direction *= -1

	if delay_timer.time_left <= 0.0:
		if not floor_raycast.is_colliding() or wall_raycast.is_colliding():
			state_machine.change_by_state(next_state)

