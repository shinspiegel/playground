extends Node

var GameManager = preload("res://Game/GameManager.gd")
var LevelManager = preload("res://Game/LevelManager.gd")
var ScreenManager = preload("res://Screens/ScreenManager.gd")

var __game_manager: GameManager
var __level_manager: LevelManager
var __screen_manager: ScreenManager

var game: GameManager setget , get_game_manager
var level: LevelManager setget , get_level_manager
var screen: ScreenManager setget , get_screen_manager


func get_game_manager() -> GameManager:
	if __game_manager == null:
		__game_manager = get_tree().root.get_node("GameManager")
	return __game_manager


func get_level_manager() -> LevelManager:
	if __level_manager == null:
		__level_manager = get_tree().root.get_node("GameManager/LevelManager")
	return __level_manager


func get_screen_manager() -> ScreenManager:
	if __screen_manager == null:
		__screen_manager = get_tree().root.get_node("GameManager/CanvasLayer/ScreenManager")
	return __screen_manager
