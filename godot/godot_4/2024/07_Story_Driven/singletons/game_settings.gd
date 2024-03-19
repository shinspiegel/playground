class_name GameSettings extends Resource

signal music_changed
@warning_ignore("unused_signal")
signal sound_changed

@export var music_volume: float = 1.0:
	get:
		return music_volume
	set(value):
		music_volume = value
		music_changed.emit()

@export var sound_volume: float = 1.0:
	get:
		return sound_volume
	set(value):
		sound_volume = value
		music_changed.emit()
