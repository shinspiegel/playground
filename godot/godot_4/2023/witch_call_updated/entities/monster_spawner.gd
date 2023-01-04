class_name MonsterSpawner extends Node2D

@export var run_data: RunData
@export var lanes: int = 3


func _ready() -> void:
	update_lanes_position()


func spawn() -> void:
	print_debug("WARN:: Need to implement")
	pass


func update_lanes_position() -> void:
	clean_markers()
	spawn_markers_for_lanes()


func spawn_markers_for_lanes() -> void:
	var limit: int = ProjectSettings.get_setting("display/window/size/viewport_width")
	var total: int = lanes + 1
	var dist = float(limit) / float(total)
	
	for n in total:
		if n == 0:
			continue
		create_spawn_marker_at(dist * n)


func create_spawn_marker_at(pos_x: float) -> void:
	var market: Marker2D = Marker2D.new()
	add_child(market)
	market.name = "Marker2D_Lane_At_%s" % [pos_x]
	market.global_position.x = pos_x


func clean_markers() -> void: 
	for child in get_children():
		child.queue_free()
