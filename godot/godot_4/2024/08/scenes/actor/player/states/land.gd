extends PlayerState

@export var anim_player: AnimationPlayer


func _ready() -> void:
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	actor.change_animation(LAND)


func update(delta: float) -> void:
	actor.apply_gravity(delta)
	actor.apple_direction(0.0, actor.data.friction_land, 0.1)
	actor.move_and_slide()
	actor.check_flip(actor.input.last_direction)


func on_anim_finished(anim: String) -> void:
	if anim == LAND:
		state_machine.change_state(IDLE)

