# AreaPreloaded
extends Node

signal area_changed_to(area: PackedScene)

const areas = {
	"mock_1": preload("res://levels/mock_level_1.tscn"),
	"mock_2": preload("res://levels/mock_level_2.tscn")
}


func change_by_name(area: String) -> void:
	if areas.has(area):
		area_changed_to.emit(areas.get(area))
	else:
		print_debug("WARN:: failed to load area [%s]. Please use a valid key for the area" % [area])


func change_to_scene(area: PackedScene) -> void:
	area_changed_to.emit(area)
