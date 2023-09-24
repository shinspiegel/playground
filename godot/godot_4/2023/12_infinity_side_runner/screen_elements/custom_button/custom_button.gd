class_name CustomButton extends BaseButton

@export var press_sfx: AudioStream
@export var focus_sfx: AudioStream


func _ready() -> void:
	focus_entered.connect(on_focus)
	pressed.connect(on_press)


func on_focus() -> void:
	AudioManager.play_sfx(focus_sfx)


func on_press() -> void:
	AudioManager.play_sfx(press_sfx)
