class_name Spawner extends Node2D

const DONUT = preload("res://donut/donut.tscn")
const BOMB = preload("res://bomb/bomb.tscn")

@export var shape: CollisionShape2D
@export var offset: int = 128
@export var spawn_colddown: Timer

var _count: int = 5


func _ready() -> void:
	GameManager.player_died.connect(on_player_die)
	GameManager.game_started.connect(func(): spawn_colddown.start())
	spawn_colddown.timeout.connect(on_timeout)


func spawn_donut() -> void:
	var x_pos = randi_range(offset, GameManager.screen_size.x - offset)
	var donut = DONUT.instantiate()
	add_child(donut)
	donut.global_position = Vector2(x_pos, -10)


func spawn_bomb() -> void:
	var x_pos = randi_range(offset, GameManager.screen_size.x - offset)
	var bomb: Bomb = BOMB.instantiate()
	add_child(bomb)
	bomb.global_position = Vector2(x_pos, -10)


func on_timeout() -> void:
	_count -= 1

	if _count < 0:
		spawn_donut()
		_count = randi_range(2, 6)
	else:
		spawn_bomb()

	spawn_colddown.start()


func on_player_die() -> void:
	spawn_colddown.stop()
