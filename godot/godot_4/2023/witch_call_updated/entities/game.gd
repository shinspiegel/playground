class_name Game extends Node2D

@export var player_scene: PackedScene
@export var run_data: RunData
@export var waves_list: Array[Wave]

@onready var start_pos: Marker2D = $StartPlayerPos
@onready var hud: CanvasLayer = $HUD
@onready var monster_spawner: MonsterSpawner = $MonsterSpawner
@onready var wave_timer: Timer = $WaveTimer

var witch: Witch
var current_wave: Wave


func _ready() -> void:
	SignalBus.start_game.connect(start_game)
	SignalBus.player_died.connect(game_over)
	
	hud.hide()
	wave_timer.timeout.connect(run_wave)


func start_game() -> void:
	SignalBus.play_game_music.emit()
	SignalBus.hide_all_menu.emit()
	SignalBus.clean_all_monster.emit()
	set_start_position()
	spawn_player()
	hud.show()
	reset_game_data()
	run_wave()


func run_wave() -> void:
	if run_data.level >= waves_list.size():
		complete_game()
		return
	
	update_current_wave()
	wave_timer.start(current_wave.time_limit)
	current_wave.execute_wave()
	run_data.increase_level()


func update_current_wave() -> void:
	var options_available: Array[Wave] = []
	
	for wave in waves_list:
		if wave.min_level >= run_data.level and wave.max_level <= run_data.level:
			options_available.append(wave)
	
	options_available.shuffle()
	current_wave = options_available[0]


func complete_game() -> void:
	wave_timer.stop()
	witch.queue_free()
	hud.hide()
	SignalBus.show_menu.emit("Complete")


func game_over() -> void:
	wave_timer.stop()
	witch.queue_free()
	hud.hide()
	SignalBus.show_menu.emit("GameOver")


func reset_game_data() -> void:
	run_data.reset()


func spawn_player() -> void:
	witch = player_scene.instantiate()
	add_child(witch)
	witch.global_position = start_pos.global_position


func set_start_position() -> void:
	start_pos.position.x = ProjectSettings.get_setting("display/window/size/viewport_width") / 2
	start_pos.position.y = ProjectSettings.get_setting("display/window/size/viewport_height") - 90
