extends Node

func horizontal() -> float:
	var deadzone : float = 0.10 
	var horizontal : float
	horizontal = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if abs(horizontal) < deadzone:
		horizontal = 0
	
	return horizontal

func is_jump_pressed() -> bool:
	if Input.is_action_pressed("btnZ"):
		return true
	else:
		return false

func is_jump_just_pressed() -> bool:
	if Input.is_action_just_pressed("btnZ"):
		return true
	else:
		return false

func is_jump_release() -> bool:
	if Input.is_action_just_released("btnZ"):
		return true
	else:
		return false

func is_attack_pressed() -> bool:
	if Input.is_action_just_pressed("btnX"):
		return true
	else:
		return false

func is_bow_pressed() -> bool:
	if Input.is_action_just_pressed("btnC"):
		return true
	else:
		return false