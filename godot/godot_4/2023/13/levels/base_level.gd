class_name BaseLevel extends Node2D

@export var debug: Debugger
@export var damage_scene: PackedScene
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


func __spawn_damage(pos: Vector2, dmg: Damage):
	var dmg_number = damage_scene.instantiate()
	add_child(dmg_number)

	if dmg_number is DamageNumber:
		dmg_number.set_damage_value(dmg)

	dmg_number.global_position = pos


func __add_camera_to_area() -> void:
	for child in areas.get_children():
		if child is BaseArea:
			child.game_camera = camera
