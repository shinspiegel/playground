extends BaseState

@export var player: Player
@export var die_effect: PackedScene
@export var inputs: PlayerInputs


func enter() -> void:
	GameManager.spawn_effect(die_effect, player.global_position, inputs.last_direction)
	GameManager.player_died.emit()
	player.queue_free()
