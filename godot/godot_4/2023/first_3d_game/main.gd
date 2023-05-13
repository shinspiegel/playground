class_name Main extends Node3D

@export var initial_area: String = ""
@onready var curr_area: Node3D = $CurrentArea


func _ready() -> void:
	AreaPreloaded.area_changed_to.connect(on_load_area)
	AreaPreloaded.change_by_name(initial_area)


func on_load_area(area: PackedScene) -> void:
	# TODO: Make a cool transition between areas
	clean_all_children()
	load_area(area)


func clean_all_children() -> void:
	for child in curr_area.get_children():
		child.queue_free()


func load_area(area: PackedScene) -> void:
	var instance = area.instantiate()
	curr_area.add_child(instance)
