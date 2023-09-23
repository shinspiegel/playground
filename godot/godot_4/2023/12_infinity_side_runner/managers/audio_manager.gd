extends Node

const MUSIC = {
	"menu": preload("res://resources/music_resources/main_music.tres"),
	"game": preload("res://resources/music_resources/game_music.tres"),
}

@onready var audio_stream_player: AudioStreamPlayer = $Music/AudioStreamPlayer
@onready var sfx: Node = $SFX
@onready var music: Node = $Music


func play_sfx(effect: AudioStream) -> void:
	var node = AudioStreamPlayer.new()
	sfx.add_child(node)
	node.play()
	node.finished.connect(func(): node.queue_free())



func play_music(music: AudioStream) -> void:
	if not music == audio_stream_player.stream:
		audio_stream_player.stop()
		audio_stream_player.stream = music
		audio_stream_player.play()


func play_music_menu() -> void: 
	play_music(MUSIC.menu)


func play_music_game() -> void: 
	play_music(MUSIC.game)


func __convert_float_to_db(value: float) -> float:
	if value >= 0:
		return log(value) * 20
	else:
		return -80.0
