class_name BaseLevel extends Node2D

@export var pos_list: Array[Node2D]


func _ready() -> void:
	GameManager.spawn_player_at(self, pos_list[0].global_position)

