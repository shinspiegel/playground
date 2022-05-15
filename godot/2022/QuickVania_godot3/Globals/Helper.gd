extends Node

var GameManager = preload("res://Game/GameManager.gd")
var LevelManager = preload("res://Game/LevelManager.gd")
var ScreenManager = preload("res://Screens/ScreenManager.gd")

var game_manager: GameManager
var level_manager: LevelManager
var screen_manager: ScreenManager


func get_game_manager() -> GameManager:
	if game_manager == null:
		game_manager = get_tree().root.get_node("GameManager")
	return game_manager


func get_level_manager() -> LevelManager:
	if level_manager == null:
		level_manager = get_tree().root.get_node("GameManager/LevelManager")
	return level_manager


func get_screen_manager() -> ScreenManager:
	if screen_manager == null:
		screen_manager = get_tree().root.get_node("GameManager/CanvasLayer/ScreenManager")
	return screen_manager
