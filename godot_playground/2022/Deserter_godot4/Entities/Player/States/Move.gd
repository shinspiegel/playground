extends BaseState

func on_process(delta:float):
	player.apply_gravity(delta)
	player.apply_horizontal_force()
	player.apply_vertical_force()
	player.move_and_slide()
	
	apply_animation()

func apply_animation():
	if floor(abs(player.motion_velocity.x)) > 10:
		player.playerAnimation.play("Move")
	else:
		player.playerAnimation.play("Idle")
