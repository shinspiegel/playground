extends Node

# Player
signal player_hp_changed(amount, max)
signal player_died


# State change signals
signal state_entered_for(target, state)
signal state_exited_for(target, state)


# Level signals
signal switch_to(target_scene, position)
signal play_background_music(music_name, volume_adjust, fade_time)


# Game Data
signal updated_music_volume_db(volume)
signal update_sound_volume_db(volume)


# Voices
signal speak_string_for(string, voice)
signal speak_for_hero(string)
signal speak_for_vampire(string)
signal speak_for_monster(string)


# SpawnMessage
signal spawn_text_message_at(target, message, voice)
signal spawn_text_message_for_hero(target, message)
signal spawn_text_message_for_vampire(target, message)
