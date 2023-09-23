extends Node

@export_range(0.0, 1.0, 0.1) var music_volume: float = 1.0
@export_range(0.0, 1.0, 0.1) var sfx_volume: float = 1.0

@onready var audio_stream_player: AudioStreamPlayer = $Music/AudioStreamPlayer
@onready var sfx: Node = $SFX
@onready var music: Node = $Music


func _ready() -> void:
	if UserStoredData:
		change_music_volume(UserStoredData.get_audio_music_volume())
		change_sfx_volume(UserStoredData.get_audio_sfx_volume())


func change_music_volume(value: float) -> void:
	music_volume = value
	audio_stream_player.volume_db = __convert_float_to_db(value)


func change_sfx_volume(value: float) -> void:
	sfx_volume = value


func save_audio_data() -> void:
	UserStoredData.save_options(music_volume, sfx_volume)


func play_sfx(effect: AudioStream, adjust_volume: float = 0.0) -> void:
	if not effect: return
	
	var node = AudioStreamPlayer.new()
	sfx.add_child(node)
	node.stream = effect
	node.volume_db = __convert_float_to_db(sfx_volume + adjust_volume)
	node.play()
	node.finished.connect(func(): node.queue_free())


func play_music(next_music: AudioStream) -> void:
	if not next_music: return
	
	if not next_music == audio_stream_player.stream:
		audio_stream_player.stop()
		audio_stream_player.stream = next_music
		audio_stream_player.volume_db = __convert_float_to_db(music_volume)
		audio_stream_player.play()


func __convert_float_to_db(value: float) -> float:
	if value >= 0:
		return log(value) * 20
	else:
		return -80.0
