class_name SFXSpawner extends Node

@export var general_game_data: GeneralGameData


func _ready() -> void:
	SignalBus.play_sfx.connect(play_sound)


func play_sound(sound: AudioStream) -> void:
	var sfx_player: AudioStreamPlayer = AudioStreamPlayer.new()
	sfx_player.set_stream(sound)
	
	add_child(sfx_player)
	
	sfx_player.set_volume_db(general_game_data.get_sound_db())
	sfx_player.play()
	sfx_player.finished.connect(func(): sfx_player.queue_free())
