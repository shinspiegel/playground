class_name LootDrop extends Node2D

@export var drop_options: Array[DropItem]

var options_list: Array[DropItem] = []


func _ready() -> void:
	for drop in drop_options:
		for _n in drop.chance:
			options_list.append(drop)


func drop_random() -> void:
	if options_list.size() <= 0:
		return
	
	options_list.shuffle()
	var drop_item = options_list[0]
	
	if not drop_item.scene == null and drop_item.scene.can_instantiate():
		var drop = drop_item.scene.instantiate()
		get_parent().get_parent().add_child(drop)
		drop.global_position = global_position
