extends BaseState

func enter():
	player.animationPlayer.play(name)


func exit():
	pass


func check_for_new_state(delta: float):
	if player.velocity.y < 0:
		stateManager.change_state("Jump")
		return
	
	if player.input.direction == 0.0:
		stateManager.change_state("Idle")
		return


func process(delta:float):
	player.apply_all(delta)
	
