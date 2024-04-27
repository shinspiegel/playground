extends PlayerState

@export var anim_player: AnimationPlayer
@export var damage_inflictor: DamageInflictor

var repeat: bool = false


func _ready() -> void:
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	player.change_animation(JAB)
	damage_inflictor.active = true


func exit() -> void:
	damage_inflictor.active = false


func update(delta: float) -> void:
	if not repeat and player.input.attack:
		repeat = true

	player.apply_gravity(delta)
	player.apply_direction(0, player.data.friction_land, 0.9)
	player.move_and_slide()
	player.check_flip(player.input.last_direction)

	if damage_inflictor.active:
		damage_inflictor.active = false


func on_anim_finished(anim: String) -> void:
	if anim == JAB:
		if repeat:
			anim_player.play(JAB)
			repeat = false

		else:
			state_machine.change_state(IDLE)
