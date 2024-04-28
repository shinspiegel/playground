extends Node2D

const MUSIC_LIST = [
	preload("res://assets/music/sample_music_1.ogg"), # 0
	preload("res://assets/music/sample_music_2.ogg"), # 1
]

@export var game_settings: SavedData
@onready var background_music: AudioStreamPlayer = $BackgroundMusic

var __background_adjust: float = 0.0

func _ready() -> void:
	game_settings.music_changed.connect(on_music_change)


func play_music(track_index: int, volume_adjust: float = 0.0, duration: float = 0.3) -> void:
	if track_index < 0 or track_index >= MUSIC_LIST.size(): 
		push_warning("invalid track index")
		return
	
	var next_music = MUSIC_LIST[track_index]
	
	if not next_music == background_music.stream:
		var tw = create_tween()
		tw.tween_property(background_music, "volume_db", -80, duration)
		tw.play()
		await tw.finished
		
		background_music.stop()
		background_music.stream = next_music
		background_music.play()
		
		tw = create_tween()
		tw.tween_property(background_music, "volume_db", __convert_float_to_db(game_settings.music_volume + volume_adjust), duration)
		tw.play()


func create_sfx(audio: AudioStream, volume_adjust: float = 0.0) -> void:
	var sfx = AudioStreamPlayer.new()
	__background_adjust = volume_adjust
	sfx.volume_db = __convert_float_to_db(game_settings.sound_volume + __background_adjust)
	sfx.stream = audio
	sfx.finished.connect(func(): sfx.queue_free())
	add_child(sfx)
	sfx.play()


func on_music_change() -> void:
	background_music.volume_db = __convert_float_to_db(game_settings.music_volume + __background_adjust)


func __convert_float_to_db(value: float) -> float:
	if value >= 0:
		return log(value) * 20
	else:
		return -80.0
