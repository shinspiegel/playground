extends InputHandler

func _input(event: InputEvent) -> void:
	if event.is_action("ui_left"):
		act_input("left")
	
	if event.is_action("ui_right"):
		act_input("right")
	
	if event.is_action("ui_up"):
		act_input("up")
	
	if event.is_action("ui_down"):
		act_input("down")
	
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("button_main"):
		act_input("main")
	
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("button_cancel"):
		act_input("cancel")
	
	if event.is_action_pressed("button_reload"):
		act_input("reload")
	
	if event.is_action_pressed("button_special"):
		act_input("special")
