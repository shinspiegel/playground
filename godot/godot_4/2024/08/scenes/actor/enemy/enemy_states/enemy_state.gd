class_name EnemyState extends BaseState

@export var enemy: BaseEnemy
@export var damage_receiver: DamageReceiver


func play_anim() -> void:
	enemy.animation_player.play(name)


func connect_damage_hit() -> void:
	damage_receiver.receive_damage.connect(enemy.on_receive_damage)


func disconnect_damage_hit() -> void:
	damage_receiver.receive_damage.disconnect(enemy.on_receive_damage)
