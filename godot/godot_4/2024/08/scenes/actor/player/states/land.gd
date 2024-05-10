extends PlayerState

@export_range(0.1, 1.0, 0.1) var duration: float = 0.4
var __timer: SceneTreeTimer

func enter() -> void:
	player.change_animation(LAND)
	__timer = get_tree().create_timer(duration)
	__timer.timeout.connect(on_timeout)


func exit() -> void:
	__timer.timeout.disconnect(on_timeout)


func update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_direction(0.0, player.data.friction_land, 0.1)
	player.move_and_slide()
	player.check_flip(player.input.last_direction)


func on_timeout() -> void:
	state_machine.change_by_name(IDLE)

