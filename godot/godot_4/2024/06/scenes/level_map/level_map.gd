class_name LevelMap extends Node2D

@export var sorted: Node2D
@export var pos: Node2D
@export var game_camera: Camera2D


func _ready() -> void:
	if not sorted: push_error("failed to locate the sorted node")
	if not pos: push_error("failed to locate the initial player position node")
	if not game_camera: push_error("missing game camera node")

	var player: PlayerActor = GameManager.current_party.front()
	player.camera = game_camera
	sorted.add_child(player)
	player.global_position = pos.global_position

