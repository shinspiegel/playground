extends PlayerState

@export var anim_player: AnimationPlayer
@export var damage_inflictor: DamageInflictor


func _ready() -> void:
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	player.change_animation(JAB)
	damage_inflictor.active = true


func exit() -> void:
	damage_inflictor.active = false


func update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_direction(0, player.data.friction_land, 0.9)
	player.move_and_slide()
	player.check_flip(player.input.last_direction)

	if damage_inflictor.active:
		damage_inflictor.active = false


func on_anim_finished(anim: String) -> void:
	if anim == JAB:
		state_machine.change_by_name(IDLE)
