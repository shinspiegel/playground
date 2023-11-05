extends BaseState

@export var player: Player
@export var animation_player: PlayerAnimation
@export var inputs: PlayerInputs


func enter() -> void:
	animation_player.idle()
	player.velocity.x = 0
	player.velocity.y = 0


func physics_process(_delta: float) -> void:
	player.move_and_slide()
