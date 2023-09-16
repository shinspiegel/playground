class_name BaseLevel extends Node2D

func _ready() -> void:
	GameManager.created_node.connect(on_node_created)
	PlayerData.health_zeroed.connect(on_player_die)


func on_player_die() -> void:
	GameManager.change_scene("title")


func on_node_created(scene: PackedScene, pos: Vector2) -> void:
	var node: Node2D = scene.instantiate()
	add_child(node)
	node.global_position = pos
