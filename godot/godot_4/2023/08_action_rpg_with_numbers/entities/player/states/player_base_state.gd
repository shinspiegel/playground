class_name PlayerState extends BaseState

@export var player: Player

func enter() -> void:
	player.anim_play_attack()

