extends BaseScreen

@export var game_data: GameData

@onready var sound_slider: Slider = $MarginContainer/VBoxContainer2/VBoxContainer/HBoxContainer/SoundSlider
@onready var music_slider: Slider = $MarginContainer/VBoxContainer2/VBoxContainer/HBoxContainer2/MusicSlider
@onready var back_button: Button = $MarginContainer/VBoxContainer2/Back


func _ready() -> void:
	sound_slider.grab_focus()
	sound_slider.value = game_data.sound_volume
	sound_slider.value_changed.connect(update_sound_volume)
	
	music_slider.value = game_data.music_volume
	music_slider.value_changed.connect(update_music_volume)
	
	back_button.pressed.connect(func(): SignalBus.switch_to.emit(Constants.SCREENS.start))
	
	SignalBus.play_background_music.emit(Constants.MUSICS.start)


func update_sound_volume(value: float) -> void:
	game_data.sound_volume = value
	SignalBus.update_sound_volume_db.emit(game_data.get_sound_db())


func update_music_volume(value: float) -> void:
	game_data.music_volume = value
	SignalBus.updated_music_volume_db.emit(game_data.get_music_db())
