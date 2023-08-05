extends Node

@onready var scenes: SceneManager = $SceneManager
@onready var sounds: SoundManager = $SoundManager
@onready var musics: MusicManager = $MusicManager
@onready var crafts: CraftManager = $CraftManager


func start_game() -> void: 
	scenes.level_selector()


func quit_game() -> void: 
	get_tree().quit()
