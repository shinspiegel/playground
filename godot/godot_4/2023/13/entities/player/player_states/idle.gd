extends BaseState

@export var player: Player
@export var animation_player: PlayerAnimation
@export var inputs: PlayerInputs


func enter() -> void:
	animation_player.idle()
	player.velocity.x = 0
	player.velocity.y = 0


func physics_process(_delta: float) -> void:
	if inputs.jump_press:
		next_state.emit("jump")
		return 
	if not inputs.direction == 0.0:
		next_state.emit("move")
		return 
	if not player.is_on_floor_coyote():
		next_state.emit("Fall")
		return 
	
	player.move_and_slide()
