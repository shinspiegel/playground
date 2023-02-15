class_name BackgroundMusic extends Node

@export var game_data: GeneralGameData

@onready var player: AudioStreamPlayer = $AudioStreamPlayer

var game_music = preload("res://assets/audio/backgroundMusic.ogg")
var menu_music = preload("res://assets/audio/backgroundMusic.ogg")


func _ready() -> void:
	SignalBus.play_game_music.connect(play_game_music)
	SignalBus.play_menu_music.connect(play_menu_music)
	SignalBus.music_change.connect(change_volume)


func play_game_music() -> void:
	play(game_music)


func play_menu_music() -> void:
	play(menu_music)


func play(playback: AudioStream) -> void:
	if player.get_stream() != playback:
		player.set_volume_db(game_data.get_music_db())
		player.set_stream(playback)
		player.play()


func change_volume(_volume: float) -> void:
	player.set_volume_db(game_data.get_music_db())
