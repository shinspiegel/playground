class_name BaseLevel extends Node2D

@export var first_area_offset: Vector2 = Vector2.ZERO
@export var level_areas_list: Array[PackedScene]
@onready var map_areas: Node2D = $MapAreas


func _ready() -> void:
	GameManager.created_node.connect(on_node_created)
	PlayerData.health_zeroed.connect(on_player_die)
	level_areas_list.reverse()
	__load_next_area()


func _physics_process(delta: float) -> void:
	__apply_speed_map_areas(delta)


func on_player_die() -> void:
	GameManager.change_scene("title")

 
func on_node_created(scene: PackedScene, pos: Vector2) -> void:
	var node: Node2D = scene.instantiate()
	map_areas.add_child(node)
	node.global_position = pos


func __load_next_area() -> void:
	if level_areas_list.size() > 0:
		var list := __get_areas_only()
		var area: LevelArea = level_areas_list.pop_back().instantiate()
		area.load_next.connect(__load_next_area)
		
		if list.size() > 0:
			map_areas.add_child(area)
			area.global_position = list[0].mark_end.global_position - area.mark_start.global_position
		else:
			map_areas.add_child(area)
			area.global_position = first_area_offset - area.mark_start.global_position


func __apply_speed_map_areas(delta: float) -> void:
	for node in map_areas.get_children():
		if node is Node2D: 
			node.global_position.x -= GameManager.get_speed(delta)


func __get_areas_only() -> Array[LevelArea]:
	var list: Array[LevelArea] = []
	for node in map_areas.get_children():
		if node is LevelArea:
			list.append(node)
	return list
