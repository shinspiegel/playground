extends BaseState

@export var player: Player
@export var animation_player: PlayerAnimation
@export var inputs: PlayerInputs
@export var min_hide_timer: Timer

func enter() -> void:
	player.disable_outline()
	player.set_hidden(true)
	min_hide_timer.start()
	

func exit() -> void:
	player.set_hidden(false)
	player.enable_outline()


func process(_delta: float) -> void:
	if inputs.is_hide_just_pressed and min_hide_timer.is_stopped():
		next_state.emit("idle")
