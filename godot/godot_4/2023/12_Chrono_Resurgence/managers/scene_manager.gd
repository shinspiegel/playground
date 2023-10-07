extends Node

const LEVELS = {
	"base_level": preload("res://levels/base_level.tscn"),
	"ancient_dynasties": preload("res://levels/desert_level.tscn"),
}

const SCREENS = {
	"main": preload("res://main.tscn"),
	"start": preload("res://screens/start_screen/start.tscn"),
	"options": preload("res://screens/options_screen/options_screen.tscn"),
	"power_selection": preload("res://screens/player_selection/player_selection.tscn"),
	"game_over": preload("res://screens/game_over_screen/game_over.tscn"),
}

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func change_scene(target: String) -> void:
	if LEVELS.has(target):
		__transition(LEVELS[target])
	elif SCREENS.has(target):
		__transition(SCREENS[target])
	else:
		print_debug("WARN::Could not locate scene to change for [%s]" % [target])


func __transition(scene: PackedScene) -> void:
	animation_player.play("animate")
	await animation_player.animation_finished
	get_tree().change_scene_to_packed(scene)
	animation_player.play_backwards("animate")
