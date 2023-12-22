class_name GameData extends Resource

@export var last_checkpoint_pos: Vector2

@export_group("Item data", "item_")
@export var item_current: int = 1
@export var item_1_unlock: bool = true
@export var item_2_unlock: bool = false
@export var item_3_unlock: bool = false


func set_item(item: int) -> void:
	item_current = item

	item_1_unlock = false
	item_1_unlock = false
	item_1_unlock = false

	match item:
		1: item_1_unlock = true
		2: item_1_unlock = true
		3: item_1_unlock = true
		_: pass
