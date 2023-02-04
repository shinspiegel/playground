extends Node

# Menus signals
signal show_menu(menu: String)
signal hide_menu(menu: String)
signal hide_all_menu()

# Config signals
signal sound_change(value: float)
signal music_change(value: float)

# Game Signals
signal start_game()
signal mana_changed_to(value: float)
signal life_changed_to(value: int)
signal score_changed_to(value: int)
signal player_died()

# Run Signals
signal spawn_monster_at(monster: PackedScene, lane: int)
signal monster_die(monster: MonsterBase)

# Music Signals
signal play_menu_music()
signal play_game_sound()
