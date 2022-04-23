extends BaseState

func enter():
	player.animationPlayer.play(name)


func exit():
	pass


func process(delta:float):
	player.apply_all(delta)
	
	if player.input.direction == 0.0:
		stateManager.change_state("Idle")
