extends BaseState

@export var player: Player
@export var animation_player: PlayerAnimation
@export var inputs: PlayerInputs


func _ready() -> void:
	animation_player.hurt_ended.connect(on_hurt_ended)


func enter() -> void:
	player.velocity.x = 0
	player.velocity.y = 0
	animation_player.hurt()


func physics_process(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_horizontal_force(inputs.direction, 1.0, 0.1)
	player.move_and_slide()


func on_hurt_ended() -> void:
	state_ended.emit("idle")
