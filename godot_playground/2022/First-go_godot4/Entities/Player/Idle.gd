extends BaseState

func enter():
	print("Entered: ", name)
	player.animationPlayer.play(name)


func exit():
	print("Exited: ", name)


func process(delta:float):
	player.direction = Input.get_axis("ui_left", "ui_right")
	
	player.apply_all(delta)
	
	if player.direction:
		stateManager.change_state("Run")
