extends Node

const  __audio = {
	"path": "user://audio_data.cfg",
	"section": "audio",
	"music_key": "music",
	"sfx_key": "sfx",
}

var __audio_config_file: ConfigFile = ConfigFile.new()


func _ready() -> void:
	if not __audio_config_file.load(__audio.path) == OK:
		save_options(1.0, 1.0)
	


func save_options(music: float, sfx: float) -> void:
	__audio_config_file.set_value(__audio.section, __audio.music_key, music)
	__audio_config_file.set_value(__audio.section, __audio.sfx_key, sfx)
	__audio_config_file.save(__audio.path)


func get_audio_music_volume() -> float:
	return __audio_config_file.get_value(__audio.section, __audio.music_key)


func get_audio_sfx_volume() -> float:
	return __audio_config_file.get_value(__audio.section, __audio.sfx_key)
