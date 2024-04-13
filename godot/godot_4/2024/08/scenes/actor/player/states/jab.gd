extends PlayerState

@export var anim_player: AnimationPlayer

var repeat: bool = false


func _ready() -> void:
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	actor.change_animation(JAB)


func update(delta: float) -> void:
	if not repeat and actor.input.attack:
		repeat = true

	actor.apply_gravity(delta)
	actor.apple_direction(0, actor.data.friction_land, 0.9)
	actor.move_and_slide()
	actor.check_flip(actor.input.last_direction)


func on_anim_finished(anim: String) -> void:
	if anim == JAB:
		if repeat:
			anim_player.play(JAB)
			repeat = false

		else:
			state_machine.change_state(IDLE)
