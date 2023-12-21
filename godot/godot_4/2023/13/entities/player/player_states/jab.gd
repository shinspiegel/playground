extends BaseState

@export var player: Player
@export var animation_player: PlayerAnimation
@export var inputs: PlayerInputs
@export var can_attack_again: bool = false


func _ready() -> void:
	animation_player.attack_ended.connect(on_attack_end)


func enter() -> void:
	animation_player.attack()
	can_attack_again = false


func physics_process(_delta: float) -> void:
	if inputs.is_attack_just_pressed and can_attack_again:
		animation_player.reset_attack()

	player.apply_horizontal_force(0)
	player.move_and_slide()


func on_attack_end() -> void:
	state_ended.emit("idle")
