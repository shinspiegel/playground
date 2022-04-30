extends BaseState

# warning-ignore:unused_argument
func update_state(delta : float):
	if character.is_on_floor():
		character.input_vector = Vector2.ZERO
		emit_signal("finished", "Idle")
	
	if Input.is_action_pressed("ui_left"):
		character.input_vector = Vector2.LEFT
	
	elif Input.is_action_pressed("ui_right"):
		character.input_vector = Vector2.RIGHT


func handle_input(event : String):
	if event == "main":
		emit_signal("finished", "Jump")
	
	elif event == "reload":
		emit_signal("finished", "SwordAttack")
