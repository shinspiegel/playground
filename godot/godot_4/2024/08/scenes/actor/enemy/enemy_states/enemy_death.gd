extends EnemyState

@export var anim_player: AnimationPlayer
@export var damage_receiver: DamageReceiver


func _ready() -> void:
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	damage_receiver.active = false
	enemy.change_animation(enemy.death_state.name)
	enemy.velocity = Vector2.ZERO
	damage_receiver.active = false


func update(delta: float) -> void:
	enemy.apply_gravity(delta)
	enemy.move_and_slide()


func on_anim_finished(anim: String) -> void:
	if anim == name:
		enemy.queue_free()


