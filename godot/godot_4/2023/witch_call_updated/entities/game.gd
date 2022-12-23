class_name Game extends Node2D

@export var player_scene: PackedScene
@export var run_data: RunData

@onready var start_pos: Marker2D = $StartPlayerPos
@onready var hud: CanvasLayer = $HUD




func _ready() -> void:
	SignalBus.start_game.connect(start_game)
	hud.hide()


func start_game() -> void:
	SignalBus.hide_all_menu.emit()
	set_start_position()
	spawn_player()
	hud.show()
	run_data.reset()
	
	# Reset all the game data
	# - Reset monster spawner?
	# - Reset score counter?
	# - Reset ui?


func spawn_player() -> void:
	var player: Node2D = player_scene.instantiate()
	add_child(player)
	player.global_position = start_pos.global_position


func set_start_position() -> void:
	start_pos.position.x = ProjectSettings.get_setting("display/window/size/viewport_width") / 2
	start_pos.position.y = ProjectSettings.get_setting("display/window/size/viewport_height") - 90

