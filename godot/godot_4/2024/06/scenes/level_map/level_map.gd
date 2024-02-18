class_name LevelMap extends Node2D

@export var sorted: Node2D
@export var pos: Node2D
@export var game_camera: Camera2D


func _ready() -> void:
	if not sorted: push_error("failed to locate the sorted node")
	if not pos: push_error("failed to locate the initial player position node")
	if not game_camera: push_error("missing game camera node")

	__spawn_party()


func __spawn_party() -> void:
	for index in PartyManager.party_size():
		var player: PlayerActor = PartyManager.at(index)
		player.global_position = pos.global_position
		player.camera = game_camera

		match index:
			0:
				player.is_user_controlled = true
			1:
				player.follow_side = -1
			2:
				player.follow_side = 1

		sorted.add_child(player)

