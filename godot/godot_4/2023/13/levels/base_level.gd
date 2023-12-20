class_name BaseLevel extends Node2D

@export var debug: Debugger
@export var player_scene: PackedScene
@export var camera: GameCamera
@export var initial_player_pos: Marker2D
@export var areas: Node2D

var __player: Player

func _ready() -> void:
	GameManager.spawn_damage_number.connect(__spawn_damage)
	__add_camera_to_area()
	__spawn_player()


## Private Methods


func __spawn_player() -> void:
	var pos: Vector2 = GameManager.get_last_checkpoint_pos()

	if pos == Vector2.ZERO:
		pos = initial_player_pos.global_position

	var playerInstance = player_scene.instantiate()

	if playerInstance is Player:
		__player = playerInstance

	if debug:
		debug.set_player(__player)

	if __player is Player:
		__player.camera = camera
		__player.global_position = pos

	add_child(__player)


func __spawn_damage():
	pass


func __add_camera_to_area() -> void:
	for child in areas.get_children():
		if child is BaseArea:
			child.game_camera = camera
