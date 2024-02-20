class_name OptionsScreen extends Control

@export var game_setting: GameSettings

@onready var sound_slider: HSlider = %SoundSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var back: Button = %Back


func _ready() -> void:
	AudioManager.play_music(AudioManager.INTRO)
	back.pressed.connect(on_back)

	sound_slider.value = game_setting.sound_volume
	sound_slider.value_changed.connect(on_sound_change)
	music_slider.value = game_setting.music_volume
	music_slider.value_changed.connect(on_music_change)

	await get_tree().create_timer(0.5).timeout
	back.grab_focus()


func on_back() -> void:
	SceneManager.change_to_file(SceneManager.SCENES.start)


func on_sound_change(val: float) -> void: 
	game_setting.sound_volume = val


func on_music_change(val: float) -> void: 
	game_setting.music_volume = val
