extends BaseState

var shot_queued: bool = false


func enter() -> void:
	if target is Player:
		target.change_animation(name)
		target.spawn_shot()
		shot_queued = false


func process(delta: float) -> void:
	if target is Player:
		target.apply_horizontal(target.input.direction)
		target.apply_gravity(delta)
	
		if shot_queued and target.spawn_shot():
			shot_queued = false


func receive_message(id: String, _message = null) -> void:
	if id == "queue_shot":
		shot_queued = true
