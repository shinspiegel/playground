extends BaseScreen

@export var game_data: GameData

@onready var music_slider: HSlider = $MarginContainer/VBoxContainer/HBoxContainer/HSlider
@onready var sound_slider: HSlider = $MarginContainer/VBoxContainer/HBoxContainer2/HSlider
@onready var back: Button = $MarginContainer/VBoxContainer/Back


func _ready() -> void:
	super()
	music_slider.value = game_data.music_volume
	sound_slider.value = game_data.sound_volume

	back.pressed.connect(func(): SignalBus.switch_to.emit(Constants.SCREENS.start))
	sound_slider.value_changed.connect(func(value:float): game_data.sound_volume = value)
	music_slider.value_changed.connect(func(value:float): game_data.music_volume = value)
