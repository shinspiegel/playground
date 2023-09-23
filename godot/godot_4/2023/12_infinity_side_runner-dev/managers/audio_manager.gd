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
	
	node.finished.connect(func(): node.queue_free())
	node.stream = effect
	node.play()



func play_music(next_music: AudioStream) -> void:
	if next_music == audio_stream_player.stream:
		return
	
	if not audio_stream_player.stream == null:
		await __tween_audio_to(-80, 1).finished
	
	audio_stream_player.stream = next_music
	audio_stream_player.play()
	
	__tween_audio_to(-30, 1)


func play_music_menu() -> void: 
	play_music(MUSIC.menu)


func play_music_game() -> void: 
	play_music(MUSIC.game)


func __convert_float_to_db(value: float) -> float:
	if value >= 0:
		return log(value) * 20
	else:
		return -80.0


func __tween_audio_to(volume: float = 0.0, duration: float = 0.2) -> Tween:
		var tween = get_tree().create_tween().set_parallel(false).set_ease(Tween.EASE_OUT)
		tween.tween_property(audio_stream_player, "volume_db", volume, duration)
		tween.play()
		
		return tween
