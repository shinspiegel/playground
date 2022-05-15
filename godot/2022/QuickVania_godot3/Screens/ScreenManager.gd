class_name ScreenManager extends Control

export(NodePath) var start_screen_path
export(NodePath) var option_screen_path
export(NodePath) var quit_screen_path
export(NodePath) var pause_menu_path

onready var screens = {}


func _ready() -> void:
	screens = {
		"start_screen": get_node(start_screen_path),
		"option_screen": get_node(option_screen_path),
		"quit_screen": get_node(quit_screen_path),
		"pause_menu": get_node(pause_menu_path),
	}

	turn_off_all()

	for screen in screens:
		var item = screens[screen]
		var con
		con = item.connect("button_with_detail_pressed", self, "on_screen_button_pressed")

		if con != OK:
			print_debug("INFO:: Failed to connect.")

		con = item.connect("toggle_checked", self, "on_screen_toggle_changed")

		if con != OK:
			print_debug("INFO:: Failed to connect.")


func switch_to_start() -> void:
	switch_to("start_screen")


func switch_to_options() -> void:
	switch_to("option_screen")


func switch_to_quit() -> void:
	switch_to("quit_screen")


func open_pause_menu() -> void:
	Helper.get_level_manager().stop_interaction()
	switch_to("pause_menu")


func close_pause_menu() -> void:
	Helper.get_level_manager().start_interation()
	turn_off_all()


func switch_to(selectedScreen: String) -> void:
	turn_off_all()
	screens[selectedScreen].visible = true
	screens[selectedScreen].default_focus()


func turn_off_all() -> void:
	for screen in screens:
		screens[screen].visible = false


func on_screen_toggle_changed(toggle_name: String, value: bool) -> void:
	match toggle_name:
		"CheckMusic":
			print_debug("Put music on: ", value)
		"CheckSound:":
			print_debug("Put sound on: ", value)
		_:
			print_debug("INFO:: failed to find checkbutton ", toggle_name)


func on_screen_button_pressed(button_name: String) -> void:
	match button_name:
		"StartGame", "PlayAgain":
			turn_off_all()
			Helper.get_game_manager().start_game()

		"Options":
			switch_to_options()

		"QuitGame":
			Helper.get_game_manager().exit_game()

		"BaseButton", "BaseButton1", "BaseButton2":
			print("Some random shit")

		"BackToGame":
			close_pause_menu()

		"BackToStart", " MainMenu":
			switch_to_start()
		_:
			print("INFO:: failed to find the button name ", button_name)
