extends Node

const player_scene = preload("res://Entities/Player/Player.tscn")

const dungeon = {
	"test": preload("res://Dungeons/TestDungeon/TestDungeon.tscn")
}

@onready var scenes: SceneManager = $SceneManager
@onready var sounds: SoundManager = $SoundManager
@onready var musics: MusicManager = $MusicManager
@onready var craft: CraftManager = $CraftManager


func start_game() -> void: 
	scenes.level_selector()


func quit_game() -> void: 
	get_tree().quit()

