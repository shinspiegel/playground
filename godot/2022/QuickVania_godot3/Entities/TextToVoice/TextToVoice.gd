class_name TextToVoice extends AudioStreamPlayer

const PITCH_MULTIPLIER_RANGE := 0.3
const INFLECTION_SHIFT := 0.4

signal characters_sounded(characters)
signal finished_phrase

export(float, 2.5, 4.5) var base_pitch := 3.5

const sounds = {
	"a": preload("res://Entities/TextToVoice/Sounds/a.wav"),
	"b": preload("res://Entities/TextToVoice/Sounds/b.wav"),
	"c": preload("res://Entities/TextToVoice/Sounds/c.wav"),
	"d": preload("res://Entities/TextToVoice/Sounds/d.wav"),
	"e": preload("res://Entities/TextToVoice/Sounds/e.wav"),
	"f": preload("res://Entities/TextToVoice/Sounds/f.wav"),
	"g": preload("res://Entities/TextToVoice/Sounds/g.wav"),
	"h": preload("res://Entities/TextToVoice/Sounds/h.wav"),
	"i": preload("res://Entities/TextToVoice/Sounds/i.wav"),
	"j": preload("res://Entities/TextToVoice/Sounds/j.wav"),
	"k": preload("res://Entities/TextToVoice/Sounds/k.wav"),
	"l": preload("res://Entities/TextToVoice/Sounds/l.wav"),
	"m": preload("res://Entities/TextToVoice/Sounds/m.wav"),
	"n": preload("res://Entities/TextToVoice/Sounds/n.wav"),
	"o": preload("res://Entities/TextToVoice/Sounds/o.wav"),
	"p": preload("res://Entities/TextToVoice/Sounds/p.wav"),
	"q": preload("res://Entities/TextToVoice/Sounds/q.wav"),
	"r": preload("res://Entities/TextToVoice/Sounds/r.wav"),
	"s": preload("res://Entities/TextToVoice/Sounds/s.wav"),
	"t": preload("res://Entities/TextToVoice/Sounds/t.wav"),
	"u": preload("res://Entities/TextToVoice/Sounds/u.wav"),
	"v": preload("res://Entities/TextToVoice/Sounds/v.wav"),
	"w": preload("res://Entities/TextToVoice/Sounds/w.wav"),
	"x": preload("res://Entities/TextToVoice/Sounds/x.wav"),
	"y": preload("res://Entities/TextToVoice/Sounds/y.wav"),
	"z": preload("res://Entities/TextToVoice/Sounds/z.wav"),
	"th": preload("res://Entities/TextToVoice/Sounds/th.wav"),
	"sh": preload("res://Entities/TextToVoice/Sounds/sh.wav"),
	" ": preload("res://Entities/TextToVoice/Sounds/blank.wav"),
	".": preload("res://Entities/TextToVoice/Sounds/longblank.wav")
}

var remaining_sounds := []


func _ready():
	var con = connect("finished", self, "play_next_sound")
	if not con == OK:
		print_debug("INFO:: Failed to connect hurt [%s]" % [name])


func play_string(in_string: String, pitch: float = 3.5):
	base_pitch = pitch
	parse_input_string(in_string)
	play_next_sound()


func play_next_sound():
	if len(remaining_sounds) == 0:
		emit_signal("finished_phrase")
		return

	var next_symbol = remaining_sounds.pop_front()

	emit_signal("characters_sounded", next_symbol.characters)

	if next_symbol.sound == "":
		play_next_sound()
		return

	var sound: AudioStreamSample = sounds[next_symbol.sound]
	pitch_scale = base_pitch + (PITCH_MULTIPLIER_RANGE * randf()) + (INFLECTION_SHIFT if next_symbol.inflective else 0.0)
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
