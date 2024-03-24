extends Node

signal state_changed()

enum MODE {WORLD, BATTLE, CUT_SCENE, TALK}

var current_mode: MODE = MODE.WORLD


func is_world() -> bool: return current_mode == MODE.WORLD
func is_battle() -> bool: return current_mode == MODE.BATTLE
func is_cut_scene() -> bool: return current_mode == MODE.CUT_SCENE
func is_talk() -> bool: return current_mode == MODE.TALK


func change_to_world() -> void:
	change_state_to(MODE.WORLD)
	AudioManager.play_music(AudioManager.Musics.INTRO)


func change_to_battle() -> void:
	change_state_to(MODE.BATTLE)
	AudioManager.play_music(AudioManager.Musics.BATTLE)


func change_to_cut_scene() -> void:
	change_state_to(MODE.CUT_SCENE)


func change_to_talk() -> void:
	change_state_to(MODE.TALK)


func change_state_to(state: MODE) -> void:
	if not state == current_mode:
		current_mode = state
		state_changed.emit()


func create_timer(seconds: float) -> SceneTreeTimer:
	return get_tree().create_timer(seconds)

