class_name BaseLevel extends Node2D

@export var player_scene: PackedScene
@export var level_width: int = 1
@export var level_height: int = 1

@onready var level_camera: Camera2D = $LevelAreaLimit/LevelCamera
@onready var camera_top_left: Marker2D = $LevelAreaLimit/TopLeft
@onready var camera_bottom_right: Marker2D = $LevelAreaLimit/BottomRight

var spawn_points: Array[Marker2D] = []


func _ready() -> void:
	for point in $SpawnPoints.get_children():
		if point is Marker2D:
			spawn_points.append(point)
	
	camera_bottom_right.global_position.x = Constants.LEVEL_SIZE.width * level_width
	camera_bottom_right.global_position.y = Constants.LEVEL_SIZE.height * level_height
	
	level_camera.limit_top = int(camera_top_left.global_position.y)
	level_camera.limit_left = int(camera_top_left.global_position.x)
	level_camera.limit_bottom = int(camera_bottom_right.global_position.y)
	level_camera.limit_right = int(camera_bottom_right.global_position.x)


func spawn_player_at(spawn_position: int = 0):
	if spawn_position >= spawn_points.size():
		spawn_position = 0
	
	var player: Player = player_scene.instantiate()
	add_child(player)
	player.global_position = spawn_points[spawn_position].global_position
	player.set_camera_on_remote(level_camera)

