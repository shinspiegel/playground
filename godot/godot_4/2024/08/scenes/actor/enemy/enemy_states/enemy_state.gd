class_name EnemyState extends BaseState

@export var enemy: BaseEnemy

func play_anim() -> void:
	enemy.animation_player.play(name)
