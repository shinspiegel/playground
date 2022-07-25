extends Node

onready var male_voice = $Voices/MaleVoice
onready var female_voice = $Voices/FemaleVoice
onready var monster_voice = $Voices/MonsterVoice


func get_voice_for(voice: String):
	var voice = male_voice

	match voice:
		"male_voice":
			voice = male_voice
		"female_voice":
			voice = female_voice
		"monster_voice":
			voice = monster_voice

	return voice
