extends BaseEnemyState

@export var damage_receiver: DamageReceiver


func enter() -> void:
	play_animation()
	animation_player.animation_finished.connect(on_finish)
	damage_receiver.set_deferred("monitorable", false)
	damage_receiver.set_deferred("monitoring", false)
	enemy.collision_layer = 0


func on_finish(_anim_name: String) -> void:
	enemy.queue_free()
