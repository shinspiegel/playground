extends Control

@onready var music_slider: HSlider = $VBoxContainer/HBoxContainer/MusicSlider
@onready var effects_slider: HSlider = $VBoxContainer/HBoxContainer2/EffectsSlider
@onready var back_button: Button = $VBoxContainer/BackButton


func _ready() -> void:
	back_button.grab_focus()
	back_button.pressed.connect(on_back)
	music_slider.value_changed.connect(on_music_change)
	music_slider.value = AudioManager.music_volume
	effects_slider.value_changed.connect(on_effect_change)
	effects_slider.value = AudioManager.sfx_volume


func on_back() -> void:
	AudioManager.save_audio_data()
	SceneManager.change_scene("start")


func on_music_change(value: float) -> void:
	AudioManager.change_music_volume(value)


func on_effect_change(value: float) -> void:
	AudioManager.change_sfx_volume(value)
