extends PlayerState

@export var anim_player: AnimationPlayer

var direction: float = 0.0


func _ready() -> void:
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	player.change_animation(ROLL)
	direction = player.input.last_direction
	player.stats.consume_mana()


func update(delta: float) -> void:
	direction = lerpf(direction, 0, delta * 1.5)

	player.apply_gravity(delta)
	player.apple_direction(direction, player.data.friction_land, 0.9)
	player.move_and_slide()
	player.check_flip(direction)


func on_anim_finished(anim: String) -> void:
	if anim == ROLL:
		if player.input.direction == 0.0:
			state_machine.change_state(IDLE)
		else:
			state_machine.change_state(MOVE)

