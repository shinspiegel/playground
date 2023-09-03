extends Control

const inventory_selection_scene = preload("res://Entities/PlayerInventory/UI_Elements/InventorySelection.tscn")
const item_selected_scene = preload("res://Entities/PlayerInventory/UI_Elements/ItemSelected.tscn")

@export var player: Player


func _ready() -> void:
	GameManager.inventory_opened.connect(on_inventory_open)
	GameManager.inventory_closed.connect(__clear_child)


func on_inventory_open() -> void:
	__clear_child()
	__create_inventory()


func on_item_select(_node: Control, item: InventoryItem) -> void:
	__clear_child()
	__create_item_selection(item)


func on_drop_item(item: InventoryItem) -> void:
	GameManager.close_inventory()
	GameManager.spawn_item(item, player.global_position)


func __create_inventory() -> void:
	var node: PlayerInventorySelection = inventory_selection_scene.instantiate()
	node.item_selected.connect(on_item_select)
	add_child(node)


func __create_item_selection(item: InventoryItem) -> void:
	var node: PlayerInventorySelected = item_selected_scene.instantiate()
	node.item = item
	node.canceled.connect(on_inventory_open)
	node.dropped_item.connect(on_drop_item)
	add_child(node)


func __clear_child() -> void:
	for child in get_children():
		child.queue_free()
