extends Node2D

func _process(_delta: float) -> void:
	var player: Sprite = get_parent()
	rotation = player.get_local_mouse_position().angle()
