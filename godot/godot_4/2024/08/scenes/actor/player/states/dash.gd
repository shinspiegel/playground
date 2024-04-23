extends PlayerState

@export var duration: Timer

var direction: float = 0.0


func _ready() -> void:
	duration.timeout.connect(on_timeout)


func enter() -> void:
	direction = actor.input.last_direction
	actor.change_animation(ROLL)
	actor.velocity = Vector2.ZERO
	actor.stats.consume_mana()
	actor.dash_used = true
	duration.start()


func update(delta: float) -> void:
	direction = lerpf(direction, 0, delta * 1.5)

	actor.apple_direction(direction, 1.0, 1.0, 3.0)
	actor.move_and_slide()
	actor.check_flip(direction)


func on_timeout() -> void:
	if actor.can_roll() and actor.input.roll:
		state_machine.change_state(ROLL)
		return

	if actor.input.just_jump and actor.can_jump():
		state_machine.change_state(JUMP)
		return

	if actor.should_fall():
		state_machine.change_state(FALLING)
		return

	if actor.input.direction == 0.0:
		state_machine.change_state(IDLE)
		return

	state_machine.change_state(MOVE)

