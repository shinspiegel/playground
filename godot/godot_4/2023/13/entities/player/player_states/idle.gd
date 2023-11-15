extends BaseState

@export var player: Player
@export var animation_player: PlayerAnimation
@export var inputs: PlayerInputs


func enter() -> void:
	animation_player.idle()
	player.velocity.x = 0
	player.velocity.y = 0
	player.start_breathing()


func exit() -> void:
	player.stop_breathing()


func physics_process(_delta: float) -> void:
	if inputs.is_jump_just_pressed:
		state_ended.emit("jump")
		return 
	if not inputs.direction == 0.0:
		state_ended.emit("move")
		return 
	if not player.is_on_floor_coyote():
		state_ended.emit("Fall")
		return
	if player.can_hide() and inputs.is_hide_just_pressed:
		state_ended.emit("hide")
		return
	if inputs.is_attack_just_pressed:
		state_ended.emit("jab")
		return
	
	player.move_and_slide()
