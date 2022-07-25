extends Node2D

onready var label: Label = $Position2D/Label
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var text_to_voice: TextToVoice = $TextToVoice


func _ready() -> void:
	setup()


func speak(text: String, volume: float = 0.0, voice = "male_voice", pitch: float = 1) -> void:
	visible = true
	label.text = text
	text_to_voice.set_volume_db(volume - 10)
	text_to_voice.play_string(text, pitch, voice)


## OVERRIDE CLASS METHODS

## SIGNAL METHODS


func on_finish_phrase() -> void:
	animation_player.play("animate")


func on_animation_finish() -> void:
	queue_free()


## SETUP METHODS


func setup() -> void:
	visible = false
	var con

	con = text_to_voice.connect("finished_phrase", self, "on_finish_phrase")
	if not con == OK:
		print_debug("INFO:: Failed to connect hurt [%s]" % [animation_player.name])

	con = animation_player.connect("animation_finished", self, "on_animation_finish")
	if not con == OK:
		print_debug("INFO:: Failed to connect hurt [%s]" % [animation_player.name])
