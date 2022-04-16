extends BaseState


# warning-ignore:unused_argument
func update_state(delta : float):
	if character.motion.y > 0:
		emit_signal("finished", "Falling")
	
	if character.motion.y < 0:
		emit_signal("finished", "Jump")
	
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"): 
		emit_signal("finished", "Move")


func handle_input(event : String):
	if event == "main":
		emit_signal("finished", "Jump")
	
	elif event == "reload":
		emit_signal("finished", "SwordAttack")
	
	else:
		emit_signal("finished", "Move")
