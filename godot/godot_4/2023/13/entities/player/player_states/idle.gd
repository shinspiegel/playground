extends BaseState

@export var player: Player
@export var animation_player: PlayerAnimation
@export var inputs: PlayerInputs


func enter() -> void:
	animation_player.idle()
	player.velocity.x = 0


func process(_delta: float) -> void:
	if inputs.jump_press:
		next_state.emit("jump")
	elif not inputs.direction == 0.0:
		next_state.emit("move")


func physics_process(delta: float) -> void:
	player.apply_gravity(delta)
	player.move_and_slide()
