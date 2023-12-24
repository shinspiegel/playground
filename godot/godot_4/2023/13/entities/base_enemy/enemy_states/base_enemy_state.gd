class_name BaseEnemyState extends BaseState

@export var enemy: BaseEnemy
@export var inputs: EnemyInput
@export var animation_player: AnimationPlayer
## Empty will use the node name as the animation name
@export var anim_name: String = ""


func play_animation() -> void:
	if anim_name.is_empty():
		animation_player.play(name)
	else:
		animation_player.play(anim_name)
