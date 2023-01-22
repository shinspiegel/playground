class_name Game extends Node2D

@export var player_scene: PackedScene
@export var run_data: RunData
@export var waves_list: Array[Wave]

@onready var start_pos: Marker2D = $StartPlayerPos
@onready var hud: CanvasLayer = $HUD
@onready var monster_spawner: MonsterSpawner = $MonsterSpawner
@onready var wave_timer: Timer = $WaveTimer


func _ready() -> void:
	SignalBus.start_game.connect(start_game)
	SignalBus.player_died.connect(game_over)
	
	hud.hide()
	wave_timer.timeout.connect(run_wave)


func start_game() -> void:
	SignalBus.hide_all_menu.emit()
	set_start_position()
	spawn_player()
	hud.show()
	reset_game_data()
	run_wave()


func run_wave() -> void:
	if run_data.level >= waves_list.size():
		complete_game()
		return
	
	var current_wave = waves_list[run_data.level]
	
	wave_timer.start(current_wave.time_limit)
	current_wave.execute_wave()
	run_data.increase_level()


func complete_game() -> void:
	print_debug("NOT IMPLEMENTED, completed game")


func game_over() -> void:
	print_debug("NOT IMPLEMENTED, game over")


func reset_game_data() -> void:
	run_data.reset()
	# Reset all the game data
	# - Reset monster spawner?
	# - Reset score counter?
	# - Reset ui?
	pass


func spawn_player() -> void:
	var player: Node2D = player_scene.instantiate()
	add_child(player)
	player.global_position = start_pos.global_position


func set_start_position() -> void:
	start_pos.position.x = ProjectSettings.get_setting("display/window/size/viewport_width") / 2
	start_pos.position.y = ProjectSettings.get_setting("display/window/size/viewport_height") - 90


