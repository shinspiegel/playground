extends Control

@onready var start: Button = $MarginContainer/VBoxContainer/VBoxContainer2/Start
@onready var quit: Button = $MarginContainer/VBoxContainer/VBoxContainer2/Quit
@onready var music_slider: HSlider = $Control/HBoxContainer/MusicSlider
@onready var sound_slider: HSlider = $Control/HBoxContainer2/SoundSlider


func _ready() -> void:
	start.pressed.connect(on_start)
	quit.pressed.connect(on_quit)
	
	music_slider.value_changed.connect(on_music_change)
	music_slider.value = GameManager.musics.get_volume()
	sound_slider.value_changed.connect(on_sound_change)
	sound_slider.value = GameManager.sounds.get_volume()
	
	start.grab_focus()


func on_start() -> void:
	GameManager.start_game()


func on_quit() -> void:
	GameManager.quit_game()


func on_music_change(val: float) -> void:
	GameManager.musics.set_volume(val)


func on_sound_change(val: float) -> void:
	GameManager.sounds.set_volume(val)
