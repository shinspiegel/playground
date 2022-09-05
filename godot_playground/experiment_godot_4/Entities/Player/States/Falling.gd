extends BaseState


func enter() -> void:
	if target is Player:
		target.velocity.y = 0
		
		var last_state = target.state_manager.get_last_state()
		
		var ignore_coyote_states = ["Jump", "Hit"]
		if not ignore_coyote_states.has(last_state):
			target.coyote_timer.start()


func exit() -> void:
	if target is Player:
		target.coyote_timer.stop()


func process(delta: float) -> void:
	if target is Player:
		update_animation()
		
		target.apply_horizontal(target.input.direction, target.speed, 0.7)
		
		if target.coyote_timer.time_left == 0.0:
			target.apply_gravity(delta)

func update_animation() -> void:
	if target is Player:
		if target.coyote_timer.time_left == 0.0:
			return target.change_animation("Falling")
		if not target.input.direction == 0.0:
			return target.change_animation("Move")
		if target.input.direction == 0.0:
			return target.change_animation("Idle")
