extends BaseState

@export var player: Player
@export var animation_player: PlayerAnimation
@export var inputs: PlayerInputs


func enter() -> void:
	player.velocity.y = 0
	animation_player.move()


func physics_process(_delta: float) -> void:
	if inputs.jump_press:
		next_state.emit("jump")
		return 
	if inputs.is_horizontal_zero():
		next_state.emit("idle")
		return 
	if not player.is_on_floor_coyote():
		next_state.emit("fall")
		return 
	
	player.apply_horizontal_force(inputs.direction)
	player.move_and_slide()

