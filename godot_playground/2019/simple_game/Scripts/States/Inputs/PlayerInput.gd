extends Node

func horizontal() -> float:
	var deadzone : float = 0.10 
	var horizontal : float
	horizontal = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if abs(horizontal) < deadzone:
		horizontal = 0
	
	return horizontal

func jump() -> bool:
	if Input.is_action_just_pressed("Jump"):
		return true
	else: 
		return false

func jump_release() -> bool: 
	if Input.is_action_just_released("Jump"):
		return true
	else:
		return false

func attack() -> bool:
	if Input.is_action_just_pressed("Attack"):
		return true
	else:
		return false
