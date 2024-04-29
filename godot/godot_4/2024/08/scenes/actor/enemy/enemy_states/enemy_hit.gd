extends EnemyState

@export var anim_player: AnimationPlayer

var last_damage: Damage


func _ready() -> void:
	damage_receiver.receive_damage.connect(on_damage_receive)
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	play_anim()
	__apply_damage()


func update(delta: float) -> void:
	enemy.apply_gravity(delta)
	enemy.move_and_slide()


func on_anim_finished(anim: String) -> void:
	if anim == name:
		if enemy.hp <= 0:
			state_machine.change_by_state(enemy.death_state)
		else:
			state_machine.change_initial()


func on_damage_receive(dmg: Damage) -> void:
	last_damage = dmg


func __apply_damage() -> void:
	if last_damage == null: return
	var direction := clampi(int(enemy.global_position.x - last_damage.source_position.x), -1, 1)
	enemy.velocity.y = (last_damage.impact * 500) * -1
	enemy.apply_direction(direction, last_damage.impact, 0.9)

