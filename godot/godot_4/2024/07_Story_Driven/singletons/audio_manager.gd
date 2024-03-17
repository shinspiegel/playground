extends Node2D

enum  Musics { BATTLE, INTRO, WORLD }

const music_res = {
	 Musics.BATTLE: preload("res://assets/music/Let's Adventure oggs sonatina.itch.io/sonatina_letsadventure_3ToArms.ogg"),
	 Musics.INTRO: preload("res://assets/music/Let's Adventure oggs sonatina.itch.io/sonatina_letsadventure_1ATaleForTheJourney.ogg"),
	 Musics.WORLD: preload("res://assets/music/Let's Adventure oggs sonatina.itch.io/sonatina_letsadventure_2Harbingers.ogg"),
}

@export var game_settings: GameSettings
@onready var background_music: AudioStreamPlayer = $BackgroundMusic

var __background_adjust: float = 0.0
var __tween: Tween

func _ready() -> void:
	game_settings.music_changed.connect(on_music_volume_change)


func play_music(next:  Musics, volume_adjust: float = 0.0, duration: float = 0.3) -> void:
	if not next: 
		push_warning("missing next music")
		return

	if not music_res.has(next):
		push_warning("invalid music request [%s]" % [next]) 
		return
	
	if not music_res.get(next) == background_music.stream:
		__tween = create_tween()
		__tween.tween_property(background_music, "volume_db", -80, duration)
		__tween.play()
		await __tween.finished

		background_music.stop()
		background_music.stream = music_res.get(next)
		background_music.play()

		__tween = create_tween()
		__tween.tween_property(background_music, "volume_db", __convert_float_to_db(game_settings.music_volume + volume_adjust), duration)
		__tween.play()


func create_sfx(audio: AudioStream, volume_adjust: float = 0.0) -> void:
	var sfx = AudioStreamPlayer.new()
	__background_adjust = volume_adjust
	sfx.volume_db = __convert_float_to_db(game_settings.sound_volume + __background_adjust)
	sfx.stream = audio
	sfx.finished.connect(func(): sfx.queue_free())
	add_child(sfx)
	sfx.play()


func on_music_volume_change() -> void:
	background_music.volume_db = __convert_float_to_db(game_settings.music_volume + __background_adjust)


func __convert_float_to_db(value: float) -> float:
	if value >= 0:
		return log(value) * 20
	else:
		return -80.0
