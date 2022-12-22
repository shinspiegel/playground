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
