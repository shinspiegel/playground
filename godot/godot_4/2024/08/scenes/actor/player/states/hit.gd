extends PlayerState

@export var anim_player: AnimationPlayer
@export var dmg_receiver: DamageReceiver

var last_damage: Damage


func _ready() -> void:
	dmg_receiver.receive_damage.connect(on_damage_receive)
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	actor.change_animation(HIT)
	__apply_damage()


func update(delta: float) -> void:
	actor.apply_gravity(delta)
	actor.move_and_slide()


func on_anim_finished(anim: String) -> void:
	if anim == HIT:
		state_machine.change_state(IDLE)


func on_damage_receive(dmg: Damage) -> void:
	last_damage = dmg


func __apply_damage() -> void:
	if last_damage == null: return
	var direction := clampi(int(actor.global_position.x - last_damage.source_position.x), -1, 1)
	actor.velocity.y = (last_damage.impact * 500) * -1
	actor.apple_direction(direction, last_damage.impact, 0.9)

