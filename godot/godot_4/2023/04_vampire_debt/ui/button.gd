extends Button

@export var pressed_sfx: AudioStream
@export var focus_sfx: AudioStream

func _ready() -> void:
	pressed.connect(func(): GameManager.play_sfx(pressed_sfx))
	focus_entered.connect(func(): GameManager.play_sfx(focus_sfx))
