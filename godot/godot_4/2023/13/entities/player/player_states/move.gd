extends BaseState

@export var player: Player
@export var animation_player: PlayerAnimation
@export var inputs: PlayerInputs


func enter() -> void:
	animation_player.move()


func process(_delta: float) -> void:
	if inputs.jump_press:
		next_state.emit("jump")
	elif not player.is_on_floor():
		next_state.emit("fall")
	elif inputs.is_horizontal_zero():
		next_state.emit("idle")


func physics_process(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_horizontal_force(inputs.direction)
	player.move_and_slide()
