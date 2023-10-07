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

var __previous_scenes: Array[String] = ["main"]


func change_scene(target: String) -> void:
	var scene: PackedScene
	
	if LEVELS.has(target):
		scene = LEVELS[target]
	elif SCREENS.has(target):
		scene = SCREENS[target]
	else:
		print_debug("WARN::Could not locate scene to change for [%s]" % [target])
	
	if scene:
		__append_previous_location(target)
		__transition(scene)


func change_scene_previous() -> void:
	change_scene(__previous_scenes[1])


func __transition(scene: PackedScene) -> void:
	animation_player.play("animate")
	await animation_player.animation_finished
	get_tree().change_scene_to_packed(scene)
	animation_player.play_backwards("animate")


func __append_previous_location(target: String) -> void:
	__previous_scenes.push_front(target)
	
	if __previous_scenes.size() > 5:
		__previous_scenes.resize(5)
