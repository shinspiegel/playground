class_name SceneManager extends Node

const scenes = {
	"main_menu": preload("res://Main.tscn"),
	"test_level": preload("res://Dungeons/TestDungeon/TestDungeon.tscn"),
	"level_selector": preload("res://Entities/LevelSelect/LevelSelect.tscn"),
}

func change(scene: PackedScene) -> void: 
	get_tree().change_scene_to_packed(scene)

func main_menu() -> void: change(scenes.main_menu)
func test_dungeon() -> void: change(scenes.test_level)
func level_selector() -> void: change(scenes.level_selector)
