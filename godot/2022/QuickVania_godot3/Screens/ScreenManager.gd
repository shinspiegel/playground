class_name ScreenManager extends Control

onready var startScreen: Screen = $Start
onready var optionScreen: Screen = $Options
onready var quitScreen: Screen = $Quit

onready var screens = {
	"startScreen": startScreen,
	"optionScreen": optionScreen,
	"quitScreen": quitScreen,
}


func _ready() -> void:
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

	switch_to_start()


func switch_to_start() -> void:
	switch_to("startScreen")


func switch_to_options() -> void:
	switch_to("optionScreen")


func switch_to_quit() -> void:
	switch_to("quitScreen")


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

		"Quit":
			Helper.get_game_manager().exit_game()

		"BaseButton", "BaseButton1", "BaseButton2":
			print("Some random shit")

		"Back":
			switch_to_start()
		_:
			print("INFO:: failed to find the button name ", button_name)
