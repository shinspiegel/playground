extends Node

const player_scene = preload("res://Entities/Player/Player.tscn")

@onready var signals: SignalManager = $SignalManager
@onready var sounds: SoundManager = $SoundManager
@onready var musics: MusicManager = $MusicManager


func start_game() -> void: 
	print("Start")


func quit_game() -> void: 
	get_tree().quit()
