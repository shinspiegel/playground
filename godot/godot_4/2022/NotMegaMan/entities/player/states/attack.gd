extends BaseState

var shot_queued: bool = false


func enter() -> void:
	if target is Player:
		target.change_animation(name)
		target.animation_player.animation_finished.connect(on_animation_finished)
		target.shot_colddown_timer.timeout.connect(on_timeout)
		shot_queued = false


func exit() -> void:
	if target is Player:
		target.animation_player.animation_finished.disconnect(on_animation_finished)
		target.shot_colddown_timer.timeout.disconnect(on_timeout)
		shot_queued = false


func process(delta: float) -> void:
	if target is Player:
		target.apply_horizontal()
		target.apply_gravity(delta)
	
	if shot_queued and target.spawn_shot():
		shot_queued = false


func on_animation_finished(_anim: StringName) -> void:
	if target is Player:
		target.spawn_shot()
		shot_queued = false


func on_timeout() -> void:
	if target is Player and not shot_queued:
		state_finished.emit("Idle")


func receive_message(id: String, _message = null) -> void:
	if id == "queue_shot":
		shot_queued = true

