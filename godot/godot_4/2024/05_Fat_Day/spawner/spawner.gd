class_name Spawner extends Node2D

const DONUT = preload("res://donut/donut.tscn")
const BOMB = preload("res://bomb/bomb.tscn")

@export var shape: CollisionShape2D
@export var offset: int = 32
@export var spawn_colddown: Timer


func _ready() -> void:
	spawn_colddown.timeout.connect(on_timeout)
	spawn_colddown.start()


func spawn_donut() -> void:
	var x_pos = randi_range(offset, GameManager.screen_size.x - offset)
	var donut = DONUT.instantiate()
	add_child(donut)
	donut.global_position = Vector2(x_pos, -10)


func on_timeout() -> void:
	spawn_donut()
	spawn_colddown.start()
