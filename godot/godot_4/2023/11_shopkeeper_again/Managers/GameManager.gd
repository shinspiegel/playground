extends Node

const base_drop_item = preload("res://Entities/DropItem/DropItem.tscn")

signal inventory_opened()
signal inventory_closed()
signal item_spawned(item: InventoryItem, pos: Vector2, scene: PackedScene)

func open_inventory() -> void:
	inventory_opened.emit()


func close_inventory() -> void:
	inventory_closed.emit()


func spawn_item(
		item: InventoryItem,
		pos: Vector2 = Vector2.ZERO, 
		scene: PackedScene = base_drop_item
	) -> void:
	item_spawned.emit(item, pos, scene)
