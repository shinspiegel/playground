class_name LootDrop extends Node2D

@export var run_data: RunData
@export var drop_options: Array[DropItem]

var options_list: Array[DropItem] = []
var max_index: int = 0

func _ready() -> void:
	for drop in drop_options:
		for _n in drop.chance:
			options_list.append(drop)
	max_index = options_list.size() - 1 


func drop_random() -> void:
	if options_list.size() <= 0:
		return
	
	var random_value = 0
	random_value = randi_range(0, max_index) + run_data.get_level_modifier()
	random_value = clampi(random_value, 0, max_index)
	
	var drop_item = options_list[random_value]
	spawn_drop(drop_item)


func spawn_drop(drop_item: DropItem) -> void:
	if not drop_item.scene == null and drop_item.scene.can_instantiate():
		var drop = drop_item.scene.instantiate()
		get_parent().get_parent().add_child(drop)
		drop.global_position = global_position
