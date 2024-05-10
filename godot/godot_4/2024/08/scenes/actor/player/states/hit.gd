extends PlayerState

@export_range(0.1, 1.0, 0.1) var duration: float = 0.4
@export var dmg_receiver: DamageReceiver
@export var hit_sound: AudioStream

var __last_damage: Damage
var __next_roll: bool = false
var __timer: SceneTreeTimer


func _ready() -> void:
	super._ready()
	dmg_receiver.receive_damage.connect(on_damage_receive)


func enter() -> void:
	AudioManager.create_sfx(hit_sound, randf_range(0.8, 1.4))
	player.change_animation(HIT)
	__next_roll = false
	__timer = get_tree().create_timer(duration)
	__timer.timeout.connect(on_timeout)

	if __last_damage:
		var direction := clampi(int(player.global_position.x - __last_damage.source_position.x), -1, 1)
		player.velocity.y = (__last_damage.impact * 500) * -1
		player.apply_direction(direction, __last_damage.impact, 0.9)


func exit() -> void:
	__timer.timeout.disconnect(on_timeout)
	__next_roll = false


func update(delta: float) -> void:
	if player.input.roll:
		__next_roll = true

	player.apply_gravity(delta)
	player.move_and_slide()


func on_timeout() -> void:
	if player.stats.hp_curr <= 0:
		state_machine.change_by_name(DIE)
	else:
		if __next_roll:
			state_machine.change_by_name(ROLL)
		else:
			state_machine.change_by_name(IDLE)


func on_damage_receive(dmg: Damage) -> void:
	__last_damage = dmg

