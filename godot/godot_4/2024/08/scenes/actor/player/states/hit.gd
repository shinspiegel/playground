extends PlayerState

@export var anim_player: AnimationPlayer
@export var dmg_receiver: DamageReceiver
@export var hit_sound: AudioStream

var __last_damage: Damage
var __next_roll: bool = false


func _ready() -> void:
	super._ready()
	dmg_receiver.receive_damage.connect(on_damage_receive)


func enter() -> void:
	AudioManager.create_sfx(hit_sound, randf_range(0.8, 1.4))
	anim_player.animation_finished.connect(on_anim_finished)
	player.change_animation(HIT)
	__next_roll = false

	if __last_damage:
		var direction := clampi(int(player.global_position.x - __last_damage.source_position.x), -1, 1)
		player.velocity.y = (__last_damage.impact * 500) * -1
		player.apply_direction(direction, __last_damage.impact, 0.9)


func exit() -> void:
	anim_player.animation_finished.disconnect(on_anim_finished)
	__next_roll = false


func update(delta: float) -> void:
	if player.input.roll:
		__next_roll = true

	player.apply_gravity(delta)
	player.move_and_slide()


func on_anim_finished(anim: String) -> void:
	if anim == HIT:
		if player.stats.hp_curr <= 0:
			state_machine.change_by_name(DIE)
		else:
			if __next_roll:
				state_machine.change_by_name(ROLL)
			else:
				state_machine.change_by_name(IDLE)


func on_damage_receive(dmg: Damage) -> void:
	__last_damage = dmg

