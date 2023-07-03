extends Node

signal score_changed(score: int)
signal music_changed(value: float, db: float)

const menu_music: AudioStreamOggVorbis = preload("res://assets/music_sfx/Jazzy Shop.ogg")
const game_music: AudioStreamOggVorbis = preload("res://assets/music_sfx/Poppy Shop.ogg")
const min_score: int = 15

@onready var background_music: AudioStreamPlayer = $BackgroundMusic
@onready var level_manager: LevelManager = $LevelManager

var start_Score: int = 0
var score: int = 0
var music_volume: float = 1.0
var sfx_volume: float = 1.0


func increase_score(amount: int) -> void:
	score += amount
	score_changed.emit(score)


## Reset score to the score from the start of the level
func reset_score_to_start_level() -> void:
	score = start_Score
	score_changed.emit(score)


## Update the start of the level score
func save_score() -> void:
	start_Score = score


func play_sfx(sound: AudioStream, adjust: float = 0.0) -> AudioStreamPlayer:
	var sfx = AudioStreamPlayer.new()
	add_child(sfx)
	sfx.stream = sound
	sfx.volume_db = convert_float_to_db(sfx_volume + adjust)
	sfx.finished.connect(func(): sfx.queue_free())
	sfx.play()
	return sfx


func play_bgmusic(music: AudioStreamOggVorbis) -> void:
	if not background_music.stream == music:
		music.loop = true
		background_music.stream = music
		background_music.play()


func play_game_background_music() -> void:
	play_bgmusic(game_music)


func play_menu_background_music() -> void:
	play_bgmusic(menu_music)


func set_music_volume(value: float) -> void:
	music_volume = value
	music_changed.emit(music_volume, convert_float_to_db(music_volume))
	background_music.volume_db = convert_float_to_db(music_volume)


func set_sfx_volume(value: float) -> void:
	sfx_volume = value


func get_music_volume_in_db() -> float:
	return convert_float_to_db(music_volume)


func get_sfx_volume_indb() -> float:
	return convert_float_to_db(sfx_volume)


func convert_float_to_db(value: float) -> float:
	if value >= 0:
		return log(value) * 20
	else:
		return -80.0


func is_happy_score() -> bool:
	return score > min_score
