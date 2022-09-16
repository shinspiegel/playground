extends BaseState


func enter():
	player.animationPlayer.play(name)


func exit():
	pass


func check_for_new_state(delta: float):
	if player.velocity.y < 0:
		stateManager.change_state("Jump")
		return
	
	if not player.input.direction == 0.0:
		stateManager.change_state("Run")
		return


func process(delta:float):
	player.apply_all(delta)

