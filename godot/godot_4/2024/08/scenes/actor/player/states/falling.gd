extends PlayerState

@export var dist_to_land: int = 600

var start_pos: Vector2 = Vector2.ZERO


func enter() -> void:
	actor.change_animation(FALLING)
	start_pos = actor.global_position


func update(delta: float) -> void:
	if actor.is_on_floor():
		if actor.global_position.distance_to(start_pos) > dist_to_land:
			state_machine.change_state(LAND)
			return

		if actor.input.direction == 0.0:
			state_machine.change_state(IDLE)
			return
		else:
			state_machine.change_state(MOVE)
			return

	actor.apply_gravity(delta)
	actor.apple_direction(actor.input.direction, actor.data.friction_air, actor.data.acceleration_falling)
	actor.move_and_slide()
	actor.check_flip(actor.input.last_direction)
