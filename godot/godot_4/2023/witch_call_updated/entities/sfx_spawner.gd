class_name SFXSpawner extends Node


func _ready() -> void:
	SignalBus.play_sfx.connect(play_sound)


func play_sound(sound: AudioStream) -> void:
	var sfx_player: AudioStreamPlayer = AudioStreamPlayer.new()
	sfx_player.set_stream(sound)
	
	add_child(sfx_player)
	
	sfx_player.play()
	sfx_player.finished.connect(func(): sfx_player.queue_free())
