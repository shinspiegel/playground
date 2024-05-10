class_name BaseLevel extends Node2D

signal segment_changed()

@export var game_settings: SavedData
@export var initial_segment: LevelSegment
@export var track_name: String = "music"

@onready var game_camera: GameCamera = %GameCamera
@onready var segments_list: Node2D = %LevelSegments
@onready var parallax_area: Node2D = %ParallaxArea
@onready var background_nodes: Node2D = %BackgroundNodes
@onready var foreground_nodes: Node2D = %ForegroundNodes
@onready var level_ui: GameUI = %GameUI

var __current_segment: LevelSegment
var __segments_map: Dictionary = {}


func _ready() -> void:
	AudioManager.play_music(track_name)

	for child in segments_list.get_children():
		if child is LevelSegment:
			child.player_entered.connect(on_player_change_segment.bind(child))
			child.disable()
			__segments_map[child.name] = child

			if __current_segment == null:
				__current_segment = child

	if initial_segment:
		__current_segment = initial_segment

	if not game_settings.saved_segment.is_empty():
		__current_segment = __segments_map.get(game_settings.saved_segment)

	__current_segment.enable()
	game_camera.set_limit_list(__current_segment.get_limit_list())

	GameManager.set_level(self)
	GameManager.game_camera = game_camera
	GameManager.spawn_player(foreground_nodes, __current_segment.respawn_point.global_position, game_camera)
	GameManager.player.died.connect(on_player_died)

	level_ui.set_player(GameManager.player)

	game_settings.saved_stats = GameManager.player.stats.duplicate(true)


func add_to_background(node: Node) -> void:
	background_nodes.add_child(node)


func add_to_foreground(node: Node) -> void:
	foreground_nodes.add_child(node)


func add_to_segment(node: Node) -> void:
	__current_segment.update_nodes.add_child(node)


func on_player_change_segment(segment: LevelSegment) -> void:
	game_camera.set_limit_list(segment.get_limit_list())

	__current_segment.disable()
	__current_segment = segment
	__current_segment.enable()

	GameManager.player.reparent.call_deferred(segment)

	game_settings.saved_segment = __current_segment.name
	game_settings.saved_stats = GameManager.player.stats.duplicate(true)
	segment_changed.emit()


func on_player_died() -> void:
	GameManager.reload_current()

