class_name CustomSlider extends Slider

@export var change_sfx: AudioStream
@export var focus_sfx: AudioStream


func _ready() -> void:
	changed.connect(on_change)
	focus_entered.connect(on_focus)


func on_change() -> void:
	AudioManager.play_sfx(change_sfx)


func on_focus() -> void:
	AudioManager.play_sfx(focus_sfx)