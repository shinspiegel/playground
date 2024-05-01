class_name BaseLevel extends Node2D

signal segment_changed()

@export var game_settings: SavedData
@export var initial_segment: LevelSegment
@export var track_index: int = 0

@onready var game_camera: GameCamera = %GameCamera
@onready var segments_list: Node2D = %LevelSegments
@onready var parallax_area: Node2D = %ParallaxArea
@onready var background_nodes: Node2D = %BackgroundNodes
@onready var foreground_nodes: Node2D = %ForegroundNodes

var current_segment: LevelSegment

var __seg_map: Dictionary = {}


func _ready() -> void:
	GameManager.player.died.connect(on_player_died)
	GameManager.game_camera = game_camera
	AudioManager.play_music(track_index)

	for child in segments_list.get_children():
		if child is LevelSegment:
			child.player_entered.connect(on_player_change_segment.bind(child))
			child.disable()
			__seg_map[child.name] = child

			if current_segment == null:
				current_segment = child

	if initial_segment:
		current_segment = initial_segment

	if not game_settings.saved_segment.is_empty():
		current_segment = __seg_map.get(game_settings.saved_segment)

	current_segment.enable()
	game_camera.set_limit_list(current_segment.get_limit_list())

	GameManager.set_level(self)
	GameManager.spawn_player(foreground_nodes, current_segment.respawn_point.global_position, game_camera)

	game_settings.saved_stats = GameManager.player.stats.duplicate(true)


func add_to_background(node: Node) -> void:
	background_nodes.add_child(node)


func add_to_foreground(node: Node) -> void:
	foreground_nodes.add_child(node)


func add_to_segment(node: Node) -> void:
	current_segment.update_nodes.add_child(node)


func on_player_change_segment(segment: LevelSegment) -> void:
	game_camera.set_limit_list(segment.get_limit_list())

	current_segment.disable()
	current_segment = segment
	current_segment.enable()

	GameManager.player.reparent.call_deferred(segment)

	game_settings.saved_segment = current_segment.name
	game_settings.saved_stats = GameManager.player.stats.duplicate(true)
	segment_changed.emit()


func on_player_died() -> void:
	GameManager.reload_current()

