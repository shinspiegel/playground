class_name MessageBubble extends Node2D

const CHAR_PER_LINE = 19
const HEIGHT = 20

signal finished

export(bool) var wait_for_key: bool = true

onready var rich_text: RichTextLabel = $Position2D/Control/NinePatchRect/CenterContainer/RichTextLabel
onready var control: Control = $Position2D/Control
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var text_to_voice: TextToVoice = $TextToVoice

var regex = RegEx.new()


func _ready() -> void:
	setup()


func _process(_delta: float) -> void:
	if wait_for_key:
		if Input.is_action_just_pressed(KeysMap.ATTACK) or Input.is_action_just_pressed(KeysMap.CANCEL):
			animation_player.play("fade_out")


func speak(text: String, wait: bool = true, volume: float = 0.0, voice = "male_voice", pitch: float = 1) -> void:
	update_control_size(calculate_block_height(text))

	visible = true
	wait_for_key = wait

	animation_player.play("fade_in")

	rich_text.set_percent_visible(0)
	rich_text.bbcode_enabled = true
	rich_text.bbcode_text = "[center]" + text + "[/center]"

	text_to_voice.set_volume_db(volume - 10)
	text_to_voice.play_string(text, pitch, voice)


func update_control_size(height: int) -> void:
	control.rect_position = Vector2(-(120 / 2), -(height / 2))
	control.rect_size = Vector2(120, height)


func calculate_block_height(text: String) -> int:
	var list = regex.search_all(text)

	for piece in list:
		var bb_code = piece.get_string()
		text = text.replace(bb_code, "")

	var lines = text.length() / CHAR_PER_LINE

	return lines * HEIGHT


## OVERRIDE CLASS METHODS

## SIGNAL METHODS


func on_finish_phrase() -> void:
	if not wait_for_key:
		animation_player.play("fade_out")


func on_animation_finish(animation_name: String) -> void:
	match animation_name:
		"fade_in":
			pass

		"fade_out":
			emit_signal("finished")
			queue_free()


## SETUP METHODS


func setup() -> void:
	regex.compile("\\[\\/?[^\\]]*\\]")

	visible = false
	var con

	con = text_to_voice.connect("finished_phrase", self, "on_finish_phrase")
	if not con == OK:
		print_debug("INFO:: Failed to connect [%s]" % [animation_player.name])

	con = animation_player.connect("animation_finished", self, "on_animation_finish")
	if not con == OK:
		print_debug("INFO:: Failed to connect [%s]" % [animation_player.name])
