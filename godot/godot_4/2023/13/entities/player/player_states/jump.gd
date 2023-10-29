extends BaseState

@export var player: Player
@export var animation_player: PlayerAnimation
@export var inputs: PlayerInputs
@export var air_friction: float = 0.6

func enter() -> void:
	animation_player.jump_up()
	player.velocity.y = -player.JUMP_VELOCITY


func process(_delta: float) -> void:
	__reset_jump_force()
	__change_jump_animation()
	__should_change_state()


func physics_process(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_horizontal_force(inputs.direction, air_friction)
	player.move_and_slide()


## Private Methods

func __reset_jump_force() -> void:
	if inputs.jump_release and player.velocity.y < 0:
		player.velocity.y = 0


func __change_jump_animation() -> void:
	if player.velocity.y == 0:
		animation_player.jump_top()
	elif player.velocity.y > 0:
		animation_player.jump_down()


func __should_change_state() -> void:
	if player.velocity.y > 0:
		next_state.emit("fall")
