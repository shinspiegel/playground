class_name GameManager extends Node2D

@export var initial_scene: PackedScene

@onready var levels = $Levels
@onready var screens = $Screens

var current_scene

func _ready() -> void:
	SignalBus.switch_to.connect(switch_to)
	switch_to(initial_scene)


func switch_to(packed_scene: PackedScene, position: int = 0) -> void:
	var scene = packed_scene.instantiate()
	
	if scene is BaseLevel:
		__clear_nodes()
		levels.add_child(scene)
		scene.spawn_player_at(position)
	
	elif scene is BaseScreen:
		__clear_nodes()
		screens.add_child(scene)
	
	else:
		print_debug("ERROR:: Failed to switch scene")

# PRIVATE

func __clear_nodes() -> void:
	for level in levels.get_children():
		level.queue_free()
	
	for scene in screens.get_children():
		scene.queue_free()
