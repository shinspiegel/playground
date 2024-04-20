extends PlayerState

@export var anim_player: AnimationPlayer
@export var stats: PlayerStats

var direction: float = 0.0


func _ready() -> void:
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	actor.change_animation(ROLL)
	direction = actor.input.last_direction
	stats.consume_mana()


func update(delta: float) -> void:
	direction = lerpf(direction, 0, delta * 1.5)

	actor.apply_gravity(delta)
	actor.apple_direction(direction, actor.data.friction_land, 0.9)
	actor.move_and_slide()
	actor.check_flip(direction)


func on_anim_finished(anim: String) -> void:
	if anim == ROLL:
		if actor.input.direction == 0.0:
			state_machine.change_state(IDLE)
		else:
			state_machine.change_state(MOVE)

