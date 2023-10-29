extends BaseState

@export var player: Player
@export var animation_player: PlayerAnimation
@export var inputs: PlayerInputs
@export var air_friction: float = 0.8


func enter() -> void:
	animation_player.jump_down()


func process(_delta: float) -> void:
	if player.is_on_floor():
		if inputs.is_horizontal_zero():
			next_state.emit("idle")
		else:
			next_state.emit("move")


func physics_process(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_horizontal_force(inputs.direction, air_friction)
	player.move_and_slide()
