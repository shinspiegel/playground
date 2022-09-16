extends Node

onready var male_voice = $MaleVoice
onready var female_voice = $FemaleVoice
onready var monster_voice = $MonsterVoice


func get_voice_for(voice: String):
	var sounds = male_voice

	match voice:
		"male_voice":
			sounds = male_voice.sounds
		"female_voice":
			sounds = female_voice.sounds
		"monster_voice":
			sounds = monster_voice.sounds

	return sounds
