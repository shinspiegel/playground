class_name Level extends Node3D

@export var bottom_level_limit: float = -5
@export var player_path: NodePath

var player_node: Player


func _ready() -> void:
	player_node = get_node(player_path)
	player_node.died.connect(on_player_die)
	GameManager.play_bgmusic(GameManager.game_music)


func _process(_delta: float) -> void:
	check_player_death()
	check_return_menu()


func check_return_menu() -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		GameManager.level_manager.load_level("main")


func check_player_death() -> void:
	if player_node.global_position.y < bottom_level_limit:
		player_node.die()



func on_player_die() -> void:
	GameManager.reload_current_scene()
