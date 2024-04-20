class_name BaseLevel extends Node2D

@export var pos_list: Array[Node2D]
@onready var game_camera: GameCamera = %GameCamera
@onready var segments_list: Node2D = %LevelSegments

var current_segment: LevelSegment


func _ready() -> void:
	GameManager.spawn_player_at(self, pos_list[0].global_position, game_camera)

	var first: bool = true
	for child in segments_list.get_children():
		if child is LevelSegment:
			child.player_entered.connect(on_player_change_segment.bind(child))

			if first:
				current_segment = child
				game_camera.set_limit_list(child.get_limit_list())
				first = false


func on_player_change_segment(segment: LevelSegment) -> void:
	game_camera.set_limit_list(segment.get_limit_list())
	current_segment = segment
