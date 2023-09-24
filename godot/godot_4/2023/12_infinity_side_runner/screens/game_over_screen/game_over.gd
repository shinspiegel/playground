extends Control

@onready var retry: Button = %Retry
@onready var main_menu: Button = %MainMenu
@onready var quit: Button = %Quit
@onready var press_colddown: Timer = $PressColddown


func _ready() -> void:
	retry.pressed.connect(on_retry)
	main_menu.pressed.connect(on_main_menu)
	quit.pressed.connect(on_quit)
	press_colddown.timeout.connect(on_timeout)


func on_timeout() -> void:
	if not retry.has_focus() and not main_menu.has_focus() and not quit.has_focus():
		retry.grab_focus()


func on_retry() -> void:
	GameManager.change_scene("power_selection")


func on_main_menu() -> void:
	GameManager.change_scene("start")


func on_quit() -> void:
	get_tree().quit()
