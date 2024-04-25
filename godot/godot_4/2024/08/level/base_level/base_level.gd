class_name BaseLevel extends Node2D

@export var game_settings: SavedData
@export var initial_segment: LevelSegment

@onready var game_camera: GameCamera = %GameCamera
@onready var segments_list: Node2D = %LevelSegments
@onready var parallax_area: Node2D = %ParallaxArea

var current_segment: LevelSegment

var __seg_map: Dictionary = {}


func _ready() -> void:
	GameManager.current_level = self
	GameManager.player.died.connect(on_player_died)
	GameManager.game_camera = game_camera

	for child in segments_list.get_children():
		if child is LevelSegment:
			child.player_entered.connect(on_player_change_segment.bind(child))
			__seg_map[child.name] = child

			if current_segment == null:
				current_segment = child

	if initial_segment:
		current_segment = initial_segment

	if not game_settings.saved_segment.is_empty():
		current_segment = __seg_map.get(game_settings.saved_segment)

	game_camera.set_limit_list(current_segment.get_limit_list())
	GameManager.spawn_player(current_segment.middle, current_segment.respawn_point.global_position, game_camera)
	game_settings.saved_stats = GameManager.player.stats.duplicate(true)


func rpawn(node: Node, layer: int = 1) -> void:
	var target: Node2D

	match layer:
		0: target = current_segment.back
		1: target = current_segment.middle
		2: target = current_segment.front
		_: target = current_segment.middle

	target.add_child(node)


func on_player_change_segment(segment: LevelSegment) -> void:
	game_camera.set_limit_list(segment.get_limit_list())
	current_segment = segment

	game_settings.saved_segment = current_segment.name
	game_settings.saved_stats = GameManager.player.stats.duplicate(true)


func on_player_died() -> void:
	GameManager.reload_current()

