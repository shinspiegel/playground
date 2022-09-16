class_name TextToVoice extends AudioStreamPlayer

const PITCH_MULTIPLIER_RANGE := 0.3
const INFLECTION_SHIFT := 0.4

signal characters_sounded(characters)
signal finished_phrase

export(float) var base_pitch := 3.5

onready var voices = $Voices

var sounds = {}
var remaining_sounds := []


func _ready():
	var con = connect("finished", self, "play_next_sound")
	if not con == OK:
		print_debug("INFO:: Failed to connect [%s]" % [name])


func play_string(in_string: String, pitch: float, voice = "male_voice"):
	sounds = voices.get_voice_for(voice)

	base_pitch = pitch
	parse_input_string(in_string)
	play_next_sound()


func play_next_sound():
	if len(remaining_sounds) == 0:
		emit_signal("finished_phrase")
		SignalBus.emit_signal("voice_ended")
		return

	var next_symbol = remaining_sounds.pop_front()

	emit_signal("characters_sounded", next_symbol.characters)

	if next_symbol.sound == "":
		play_next_sound()
		return

	var sound: AudioStreamSample = sounds[next_symbol.sound]
	var random_noise_pitch = PITCH_MULTIPLIER_RANGE * randf()
	var inflaction_pitch = 0.0

	if next_symbol.inflective:
		inflaction_pitch = INFLECTION_SHIFT

	pitch_scale = base_pitch + random_noise_pitch + inflaction_pitch
	stream = sound
	play()


func parse_input_string(in_string: String):
	for word in in_string.split(" "):
		parse_word(word)
		add_symbol(" ", " ", false)


func parse_word(word: String):
	var skip_char := false
	var is_inflective := word[-1] == "?"

	for i in range(len(word)):
		if skip_char:
			skip_char = false
			continue

		if i < len(word) - 1:
			var two_character_substring = word.substr(i, i + 2)

			if two_character_substring.to_lower() in sounds.keys():
				add_symbol(two_character_substring.to_lower(), two_character_substring, is_inflective)
				skip_char = true
				continue

		if word[i].to_lower() in sounds.keys():
			add_symbol(word[i].to_lower(), word[i], is_inflective)
		else:
			add_symbol("", word[i], false)


func add_symbol(sound: String, characters: String, inflective: bool):
	remaining_sounds.append({"sound": sound, "characters": characters, "inflective": inflective})
