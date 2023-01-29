extends Control

@export var game_data: GeneralGameData

@onready var music: HSlider = %MusicRange
@onready var music_label: Label = %MusicLabel
@onready var sound: HSlider = %SoundRange
@onready var sound_label: Label = %SoundLabel
@onready var back: Button = %Back 


func _ready() -> void:
	back.pressed.connect(func(): SignalBus.show_menu.emit("MainMenu"))
	music.value_changed.connect(on_music_change)
	music.value = game_data.music_volume
	music_label.text = str(game_data.music_volume * 100) + "%"
	sound.value_changed.connect(on_sound_change)
	sound.value = game_data.sound_volume
	sound_label.text = str(game_data.sound_volume * 100) + "%"
	draw.connect(func(): back.grab_focus())


func on_music_change(value: float) -> void:
	game_data.music_volume = value
	music_label.text = str(value * 100) + "%"
	SignalBus.music_change.emit(value)


func on_sound_change(value: float) -> void:
	game_data.sound_volume = value
	sound_label.text = str(value * 100) + "%"
	SignalBus.sound_change.emit(value)
