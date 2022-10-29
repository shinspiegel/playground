class_name GameManager extends Node2D

@export var game_data: GameData
@export var initial_scene: PackedScene

@onready var levels: Node2D = $Levels
@onready var screens: CanvasLayer = $Screens
@onready var overlay_mask: Control = $OverlayGroup/OverlayMask


func _ready() -> void:
	SignalBus.switch_to.connect(switch_to)
	SignalBus.player_died.connect(func(): switch_to(Constants.SCREENS.game_over))
	
	overlay_mask.set_modulate(Color(1, 1, 1, 1))
	
	switch_to(initial_scene)


func switch_to(packed_scene: PackedScene, spawn_index: int = 0) -> void:
	var scene = packed_scene.instantiate()
	var tween: Tween = get_tree().create_tween()
	var fade_time: float = 0.3
	
	# Fade out
	tween.tween_property(overlay_mask, "modulate", Color(1,1,1,1), fade_time)
	await tween.finished
	tween.stop()

	if scene is BaseLevel:
		__clear_nodes()
		levels.add_child(scene)
		scene.spawn_player_at(spawn_index)
		
	elif scene is BaseScreen:
		__clear_nodes()
		screens.add_child(scene)
	
	else:
		print_debug("ERROR:: Failed to switch scene")
	
	# Fade in
	tween.tween_property(overlay_mask, "modulate", Color(1,1,1,0), fade_time)
	tween.play()


# PRIVATE


func __clear_nodes() -> void:
	for level in levels.get_children():
		level.queue_free()
	
	for scene in screens.get_children():
		scene.queue_free()
