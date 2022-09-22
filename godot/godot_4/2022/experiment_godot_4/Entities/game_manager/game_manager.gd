class_name GameManager extends Node2D

@export var initial_scene: PackedScene

@onready var levels: Node2D = $Levels
@onready var screens: CanvasLayer = $Screens
@onready var background_music_player: AudioStreamPlayer = $BackgroundMusic


func _ready() -> void:
	SignalBus.switch_to.connect(switch_to)
	SignalBus.play_background_music.connect(play_background_music)
	
	switch_to(initial_scene)


func switch_to(packed_scene: PackedScene, spawn_index: int = 0) -> void:
	var scene = packed_scene.instantiate()
	
	if scene is BaseLevel:
		__clear_nodes()
		levels.add_child(scene)
		scene.spawn_player_at(spawn_index)
	
	elif scene is BaseScreen:
		__clear_nodes()
		screens.add_child(scene)
	
	else:
		print_debug("ERROR:: Failed to switch scene")


func play_background_music(music_stream: AudioStream, volume_adjust: float = 0.0) -> void:
	if not music_stream == background_music_player.get_stream():
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(background_music_player, "volume_db", -80, 1)
		await tween.finished
		tween.stop()
		
		background_music_player.set_stream(music_stream)
		tween.tween_property(background_music_player, "volume_db", volume_adjust, 1)
		
		if not background_music_player.is_playing():
			background_music_player.play()
		
		tween.play()


# PRIVATE


func __clear_nodes() -> void:
	for level in levels.get_children():
		level.queue_free()
	
	for scene in screens.get_children():
		scene.queue_free()
