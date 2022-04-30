extends BaseState

func enter():
	player.animationPlayer.play(name)


func exit():
	pass


func check_for_new_state(delta: float):
	if player.is_on_floor():
		if not player.velocity.x == 0:
			stateManager.change_state("Run")
			return
		
		stateManager.change_state("Idle")


func process(delta:float):
	player.apply_all(delta)

