class_name MusicPlayer extends Node

signal music_changed


@export_range(0,1,0.1) var master_volume: float = 1.0
@export var fade_out_time: float = 0.3
@export var fade_in_time: float = 0.5

@onready var player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	SignalBus.music.connect(play_music)
	player.set_volume_db(-80)


func play_music(stream:AudioStream, adjust_volume_db: float = 0.0) -> void:
	if not player.get_stream() == stream:
		var tween: Tween = get_tree().create_tween()
		var volume = Utils.float_to_volume_db(master_volume) + adjust_volume_db
		
		if player.is_playing():
			tween.tween_property(player, "volume_db", -80, fade_out_time)
			tween.play()
			await tween.finished
			tween.stop()
		
		player.set_stream(stream)
		
		if not player.is_playing():
			player.play()
		
		music_changed.emit()
		
		tween.tween_property(player, "volume_db", volume, fade_in_time)
		tween.play()

