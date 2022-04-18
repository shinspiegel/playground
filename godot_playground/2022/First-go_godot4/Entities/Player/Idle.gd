extends BaseState

func enter():
	print("Entered: ", name)
	player.animationPlayer.play(name)


func exit():
	print("Exited: ", name)


func process(delta:float):
	player.apply_all(delta)
	
	if not player.input.direction == 0.0:
		stateManager.change_state("Run")
