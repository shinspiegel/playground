class_name BackgroundMusic extends Node

@export var game_data: GeneralGameData
@export var game_music: AudioStream
@export var menu_music: AudioStream

@onready var player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	SignalBus.play_game_music.connect(play_game_music)
	SignalBus.play_menu_music.connect(play_menu_music)
	SignalBus.music_change.connect(change_volume)


func play_game_music() -> void:
	play(game_music)


func play_menu_music() -> void:
	play(menu_music)


func play(playback: AudioStream) -> void:
	if not player.get_stream() == playback:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(player, "volume_db", -90, 0.5)
		tween.play()
		
		await tween.finished
		tween.stop()
		
		tween.tween_property(player, "volume_db", game_data.get_music_db(), 0.5)
		player.set_stream(playback)
		player.play()
		tween.play()


func change_volume(_volume: float) -> void:
	player.set_volume_db(game_data.get_music_db())
