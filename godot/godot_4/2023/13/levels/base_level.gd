class_name BaseLevel extends Node2D

@export var debug: Debugger
@export var player_scene: PackedScene
@export var camera: GameCamera
@export var initial_player_pos: Marker2D


func _ready() -> void:
	__spawn_player()


## Private Methods


func __spawn_player() -> void:
	var pos: Vector2 = GameManager.get_last_checkpoint_pos()
	
	if pos == null:
		pos = initial_player_pos.global_position
	
	var player = player_scene.instantiate()
	
	if debug:
		debug.set_player(player)
	
	if player is Player:
		player.camera = camera
		player.global_position = pos
		
	add_child(player)
