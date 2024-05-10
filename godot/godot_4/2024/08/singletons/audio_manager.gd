extends Node2D

const MUSIC_LIST = {
	"intro": preload("res://assets/music/composed/intro.mp3"),
	"forest": preload("res://assets/music/composed/forest.mp3"),
}


@export var game_settings: SavedData
@onready var background_music: AudioStreamPlayer = $BackgroundMusic

var __background_adjust: float = 0.0

func _ready() -> void:
	game_settings.music_changed.connect(on_music_change)


func play_music_intro() -> void: play_music("intro")
func play_music_forest() -> void: play_music("forest")
func play_music(track_name: String, volume_adjust: float = 0.0, duration: float = 0.3) -> void:
	if not MUSIC_LIST.has(track_name):
		push_error("invalid track name")
		return

	var next_music = MUSIC_LIST.get(track_name)

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



func create_sfx(audio: AudioStream, pitch: float = 1.0, volume_adjust: float = 0.0) -> void:
	var sfx: AudioStreamPlayer = AudioStreamPlayer.new()
	sfx.pitch_scale = pitch
	sfx.volume_db = __convert_float_to_db(game_settings.sound_volume + volume_adjust)
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
