extends BaseState

@export var player: Player
@export var animation_player: PlayerAnimation
@export var inputs: PlayerInputs
@export_range(0.0, 1.0, 0.1) var hide_delay: float = 0.3


var __can_exit: bool = false

func enter() -> void:
	__can_exit = false
	player.disable_outline()
	player.set_hidden(true)
	await get_tree().create_timer(hide_delay).timeout
	__can_exit = true
	

func exit() -> void:
	player.set_hidden(false)
	player.enable_outline()


func process(_delta: float) -> void:
	if inputs.is_hide_just_pressed and __can_exit:
		next_state.emit("idle")
