extends Node

const drop_item_scene = preload("res://Entities/InteractableObjects/DropItem/DropItem.tscn")
const bomb_item_scene = preload("res://Entities/InteractableObjects/ExplosiveItem/ExplosiveItem.tscn")

signal inventory_opened()
signal inventory_closed()
signal item_spawned(item: Resource, pos: Vector2, scene: PackedScene)

func open_inventory() -> void:
	inventory_opened.emit()


func close_inventory() -> void:
	inventory_closed.emit()


func spawn_item(item: InventoryItem, pos: Vector2 = Vector2.ZERO, scene: PackedScene = drop_item_scene) -> void:
	item_spawned.emit(item, pos, scene)


func spawn_bomb(item: InventoryBomb, pos: Vector2 = Vector2.ZERO, scene: PackedScene = bomb_item_scene) -> void:
	item_spawned.emit(item, pos, scene)
