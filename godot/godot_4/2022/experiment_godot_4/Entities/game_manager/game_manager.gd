extends Node2D

@onready var levels = $Levels
@onready var screens = $Screens




func _ready() -> void:
	SignalBus.switch_to.connect(switch_to)


func switch_to(target: String, position: int = 0) -> void:
	if Constants.LEVELS.has(target):
		clear_nodes()
		levels.add_child(Constants.LEVELS[target].instantiate())
		# TODO: Add logic to spawn player
	
	elif Constants.SCREENS.has(target):
		clear_nodes()
		screens.add_child(Constants.SCREENS[target].instantiate())
	
	else:
		print_debug("ERROR:: Failed to locate target [%s]" % [target])


func clear_nodes() -> void:
	for level in levels.get_children():
		level.queue_free()
	
	for scene in screens.get_children():
		scene.queue_free()
