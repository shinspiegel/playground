extends BaseState

@export var player: Player
@export var animation_player: PlayerAnimation
@export var inputs: PlayerInputs


func enter() -> void:
	player.velocity.y = 0
	animation_player.move()


func physics_process(_delta: float) -> void:
	if inputs.is_jump_just_pressed:
		state_ended.emit("jump")
		return 
	if inputs.is_horizontal_zero():
		state_ended.emit("idle")
		return 
	if not player.is_on_floor_coyote():
		state_ended.emit("fall")
		return 
	if player.can_hide() and inputs.is_hide_just_pressed:
		state_ended.emit("hide")
		return
	if inputs.is_attack_just_pressed:
		state_ended.emit("jab")
		return
	
	player.apply_horizontal_force(inputs.direction)
	player.move_and_slide()
