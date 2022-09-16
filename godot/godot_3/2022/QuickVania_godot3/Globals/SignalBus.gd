extends Node
#warning-ignore-all: UNUSED_SIGNAL

# Player
signal player_entered_room(pos_x, pox_y)
signal player_damaged(max_hp, curr_hp)
signal player_died

# Dialogue / Text to Voice
signal voice_ended

# Transition
signal transition_blacked
signal transition_cleaned

# Scenes
signal cut_scene_ended
