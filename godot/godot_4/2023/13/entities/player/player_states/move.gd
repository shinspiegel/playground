extends BaseState

@export var player: Player
@export var animation_player: PlayerAnimation
@export var inputs: PlayerInputs


func enter() -> void:
	player.velocity.y = 0
	animation_player.move()


func physics_process(_delta: float) -> void:
	if inputs.is_jump_just_pressed:
		next_state.emit("jump")
		return 
	if inputs.is_horizontal_zero():
		next_state.emit("idle")
		return 
	if not player.is_on_floor_coyote():
		next_state.emit("fall")
		return 
	if player.can_hide() and inputs.is_hide_just_pressed:
		next_state.emit("hide")
		return
	if inputs.is_attack_just_pressed:
		next_state.emit("jab")
		return
	
	player.apply_horizontal_force(inputs.direction)
	player.move_and_slide()
