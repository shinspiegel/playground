extends BasePlayerState

@export var die_effect: PackedScene


func enter() -> void:
	GameManager.spawn_effect(die_effect, player.global_position, inputs.last_direction)
	GameManager.player_died.emit()
	player.queue_free()
