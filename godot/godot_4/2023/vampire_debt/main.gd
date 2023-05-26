extends Node3D

@export var menu_select_sfx: AudioStream
@export var menu_click_sfx: AudioStream
@export var first_level: PackedScene

@onready var start_button: Button = %Start
@onready var options_button: Button = %Options
@onready var quit_button: Button = %Quit
@onready var back_button: Button = %Back
@onready var music_slider: HSlider = %Music
@onready var sound_slider: HSlider = %Sound
@onready var main_menu_area: Control = $UI/MainMenu
@onready var options_menu_area: Control = $UI/OptionsMenu
@onready var controls_hint_area: VBoxContainer = $UI/ControlsHint


func _ready() -> void:
	GameManager.play_menu_background_music()
	
	main_menu_area.show()
	controls_hint_area.show()
	options_menu_area.hide()
	
	start_button.pressed.connect(on_start_button_pressed)
	options_button.pressed.connect(on_options_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)
	back_button.pressed.connect(on_back_button_pressed)
	music_slider.value_changed.connect(on_music_changed)
	sound_slider.value_changed.connect(on_sound_changed)
	
	music_slider.value = GameManager.music_volume
	sound_slider.value = GameManager.sfx_volume
	
	start_button.grab_focus()


func on_start_button_pressed() -> void:
	GameManager.level_manager.load_level("0")


func on_options_button_pressed() -> void:
	main_menu_area.hide()
	controls_hint_area.hide()
	options_menu_area.show()
	back_button.grab_focus()


func on_quit_button_pressed() -> void:
	get_tree().quit()


func on_back_button_pressed() -> void:
	main_menu_area.show()
	controls_hint_area.show()
	options_menu_area.hide()
	start_button.grab_focus()


func on_music_changed(value: float) -> void:
	GameManager.play_sfx(menu_select_sfx)
	GameManager.set_music_volume(value)


func on_sound_changed(value: float) -> void:
	GameManager.play_sfx(menu_select_sfx)
	GameManager.set_sfx_volume(value)
