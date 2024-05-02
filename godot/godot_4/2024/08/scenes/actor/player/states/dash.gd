extends PlayerState

@export var duration: Timer

var direction: float = 0.0
var speed_weight: float = 1.5


func enter() -> void:
	direction = player.input.last_direction

	player.change_animation(ROLL)
	player.velocity = Vector2.ZERO
	player.stats.consume_mana()
	player.dash_used = true

	duration.timeout.connect(on_timeout)
	duration.start()


func exit() -> void:
	duration.timeout.disconnect(on_timeout)
	duration.stop()


func update(delta: float) -> void:
	direction = lerpf(direction, 0, delta * speed_weight)

	player.apply_direction(direction, 1.0, 1.0, 3.0)
	player.move_and_slide()
	player.check_flip(direction)


func on_timeout() -> void:
	if player.can_roll() and player.input.roll:
		state_machine.change_by_name(ROLL)
		return

	if player.input.just_jump and player.can_jump():
		state_machine.change_by_name(JUMP)
		return

	if player.should_fall():
		state_machine.change_by_name(FALLING)
		return

	if player.input.direction == 0.0:
		state_machine.change_by_name(IDLE)
		return

	state_machine.change_by_name(MOVE)

