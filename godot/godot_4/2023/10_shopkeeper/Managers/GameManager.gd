extends Node

const player_scene = preload("res://Entities/Player/Player.tscn")

const dungeon = {
	"test": preload("res://Dungeons/TestDungeon/TestDungeon.tscn")
}

@onready var signals: SignalManager = $SignalManager
@onready var sounds: SoundManager = $SoundManager
@onready var musics: MusicManager = $MusicManager


func start_game() -> void: 
	get_tree().change_scene_to_packed(dungeon.test)


func quit_game() -> void: 
	get_tree().quit()
