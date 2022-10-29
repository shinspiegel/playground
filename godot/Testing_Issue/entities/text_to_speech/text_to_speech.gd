class_name TextToSpeech extends AudioStreamPlayer

class SoundItem:
	var sound: String
	var characters: String
	var inflective: bool
	
	func _init(letter: String, is_inflective: bool):
		sound = letter.to_lower()
		characters = letter
		inflective = is_inflective


signal characters_sounded(characters)
signal finished_phrase()

@export var game_data: GameData
@export var base_pitch: float = 3.0

@onready var voices = $Voices

var remaining_sounds: Array[SoundItem] = []
var voice
var voice_keys: Array[String]


func _ready():
	finished.connect(play_next_sound)
	SignalBus.speak_string_for.connect(play_string_for)
	SignalBus.speak_for_hero.connect(func(string: String): play_string_for(string, Constants.VOICES_NAME.hero))
	SignalBus.speak_for_vampire.connect(func(string: String): play_string_for(string, Constants.VOICES_NAME.vampire))
	SignalBus.speak_for_monster.connect(func(string: String): play_string_for(string, Constants.VOICES_NAME.default))


func speak_for_hero(speech: String):
	play_string_for(speech, "hero_voice")


func speak_for_vampire(speech: String):
	play_string_for(speech, "vampire_voice")


func play_string_for(text_to_speak: String, voice_name: String = "default_voice"):
	print(game_data.get_sound_db())
	set_volume_db(game_data.get_sound_db())
	voice = voices[voice_name]
	parse_input_string(text_to_speak)
	play_next_sound()
 

func play_next_sound():
	if len(remaining_sounds) == 0:
		finished_phrase.emit()
		return
	
	var next_symbol = remaining_sounds.pop_front()
	characters_sounded.emit(next_symbol.characters)
	
	if next_symbol.sound == '':
		play_next_sound()
		return
	
	var sound_stream: AudioStream = voice[next_symbol.sound]
	var pitch_with_random = Constants.VOICES.PITCH_MULTIPLIER_RANGE * randf()
	var inflective_sound = 0.0
	
	if next_symbol.inflective:
		inflective_sound = Constants.VOICES.INFLECTION_SHIFT
	
	pitch_scale = base_pitch + pitch_with_random + inflective_sound
	
	stream = sound_stream
	play()


func parse_input_string(in_string: String):
	voice_keys = voice.keys()
	
	for word in in_string.split(' '):
		parse_word(word)
		remaining_sounds.append(SoundItem.new(" ", false))


func parse_word(word: String):
	var skip_char := false
	var is_inflective := word[-1] == '?'
	
	for i in range(len(word)):
		if skip_char:
			skip_char = false
			continue
		
		var letter = word[i]
		
		if i < len(word) - 1:
			var two_character_substring = word.substr(i, i+2)
			
			if two_character_substring.to_lower() in voice_keys:
				remaining_sounds.append(SoundItem.new(two_character_substring, is_inflective))
				skip_char = true
				continue
		
		if letter.to_lower() in voice_keys:
			remaining_sounds.append(SoundItem.new(letter, is_inflective))
		else:
			remaining_sounds.append(SoundItem.new("", false))

