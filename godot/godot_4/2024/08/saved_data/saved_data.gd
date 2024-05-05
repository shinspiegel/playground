class_name SavedData extends Resource

signal music_changed
signal sound_changed

@export var music_volume: float = 0.5:
	get:
		return music_volume
	set(value):
		music_volume = value
		music_changed.emit()
		emit_changed()


@export var sound_volume: float = 0.5:
	get:
		return sound_volume
	set(value):
		sound_volume = value
		sound_changed.emit()
		emit_changed()


@export var saved_stats: PlayerStats = PlayerStats.new()
@export var saved_power_ups: PowerUps = PowerUps.new()
@export var saved_segment: String = ""

@export var forest_level_copleted: bool = false
@export var beach_level_copleted: bool = false
@export var vulcano_level_copleted: bool = false

