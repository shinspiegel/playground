extends Node

signal state_changed()

enum MODE {WORLD, BATTLE, CUT_SCENE}

var current_mode: MODE = MODE.WORLD


func change_to_world() -> void: 
	change_state_to(MODE.WORLD)
	AudioManager.play_music(AudioManager.WORLD)


func change_to_battle() -> void: 
	change_state_to(MODE.BATTLE)
	AudioManager.play_music(AudioManager.BATTLE)


func change_to_cut_scene() -> void: 
	change_state_to(MODE.CUT_SCENE)


func change_state_to(state: MODE) -> void:
	if not state == current_mode:
		current_mode = state
		state_changed.emit()


func is_world() -> bool: 
	return current_mode == MODE.WORLD


func is_battle() -> bool: 
	return current_mode == MODE.BATTLE


func is_cut_scene() -> bool: 
	return current_mode == MODE.CUT_SCENE

