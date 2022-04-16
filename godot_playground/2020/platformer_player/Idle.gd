extends BaseState

func _apply_state(_delta: float):
	if Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") != 0:
		stateManager._change_state("Move")
