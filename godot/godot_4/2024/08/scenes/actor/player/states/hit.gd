extends PlayerState

@export var anim_player: AnimationPlayer
@export var dmg_receiver: DamageReceiver

var last_damage: Damage


func enter() -> void:
	dmg_receiver.receive_damage.connect(on_damage_receive)
	anim_player.animation_finished.connect(on_anim_finished)
	player.change_animation(HIT)
	__apply_damage()


func exit() -> void:
	dmg_receiver.receive_damage.disconnect(on_damage_receive)
	anim_player.animation_finished.disconnect(on_anim_finished)


func update(delta: float) -> void:
	player.apply_gravity(delta)
	player.move_and_slide()


func on_anim_finished(anim: String) -> void:
	if anim == HIT:
		if player.stats.hp_curr <= 0:
			state_machine.change_by_name(DIE)
		else:
			state_machine.change_by_name(IDLE)


func on_damage_receive(dmg: Damage) -> void:
	last_damage = dmg


func __apply_damage() -> void:
	if last_damage == null: return
	var direction := clampi(int(player.global_position.x - last_damage.source_position.x), -1, 1)
	player.velocity.y = (last_damage.impact * 500) * -1
	player.apply_direction(direction, last_damage.impact, 0.9)

