extends Node2D

@export var initial_scene: PackedScene

@onready var levels: Node2D = $CurrentLevel
@onready var screens: CanvasLayer = $CurrentScreen


func _ready() -> void:
	SignalBus.switch_to.connect(switch_to)
	SignalBus.player_died.connect(game_over)
	switch_to(initial_scene)


func switch_to(packed_scene: PackedScene) -> void:
	var scene = packed_scene.instantiate()
	
	if scene is BaseLevel:
		__clear_nodes()
		levels.add_child(scene)
		
	elif scene is BaseScreen:
		__clear_nodes()
		screens.add_child(scene)
	
	else:
		print_debug("ERROR:: Failed to switch scene")


func game_over() -> void:
	pass


func __clear_nodes() -> void:
	for level in levels.get_children():
		level.queue_free()
	
	for screen in screens.get_children():
		screen.queue_free()
