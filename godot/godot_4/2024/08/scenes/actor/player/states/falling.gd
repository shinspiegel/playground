extends PlayerState

@export var dist_to_land: int = 800

var start_pos: Vector2 = Vector2.ZERO


func enter() -> void:
	player.change_animation(FALLING)
	start_pos = player.global_position


func update(delta: float) -> void:
	if player.is_on_floor():
		if player.global_position.distance_to(start_pos) > dist_to_land:
			state_machine.change_by_name(LAND)
			return

		if player.input.direction == 0.0:
			state_machine.change_by_name(IDLE)
			return
		else:
			state_machine.change_by_name(MOVE)
			return

	if player.can_dash() and player.input.dash:
		state_machine.change_by_name(DASH)

	if player.can_jump() and player.input.just_jump:
		state_machine.change_by_name(JUMP)
		return

	player.apply_gravity(delta)
	player.apply_direction(player.input.direction, player.data.friction_air, 0.05)
	player.move_and_slide()
	player.check_flip(player.input.last_direction)
