extends AudioStreamPlayer

@export var game_data: GameData


func _ready() -> void:
	SignalBus.play_background_music.connect(play_background_music)
	SignalBus.updated_music_volume_db.connect(func(volume: float): set_volume_db(volume))
	set_volume_db(-80)


func play_background_music(music_stream: AudioStream, volume_adjust: float = 0.0, fade_time: float = 0.4) -> void:
	if not music_stream == get_stream():
		var tween: Tween = get_tree().create_tween()
		
		if is_playing():
			tween.tween_property(self, "volume_db", -80, fade_time)
			await tween.finished
			tween.stop()
		
		set_stream(music_stream)
		
		if not is_playing():
			play()
		
		tween.tween_property(self, "volume_db", game_data.get_music_db() + volume_adjust, fade_time)
		tween.play()
