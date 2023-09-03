extends Node

const drop_item_scene = preload("res://Entities/InteractableObjects/DropItem/DropItem.tscn")
const bomb_item_scene = preload("res://Entities/InteractableObjects/ExplosiveItem/ExplosiveItem.tscn")
const explosion_scene = preload("res://Entities/Explosion/Explosion.tscn")
const damage_number_scene = preload("res://Entities/DamageNumber/DamageNumber.tscn")


signal inventory_opened()
signal inventory_closed()
signal item_spawned(item: Resource, pos: Vector2, scene: PackedScene)
signal damage_spawned(damage: Damage, pos: Vector2, scene: PackedScene)

var is_inventory_open: bool = false



func open_inventory() -> void:
	is_inventory_open = true
	inventory_opened.emit()


func close_inventory() -> void:
	is_inventory_open = false
	inventory_closed.emit()


func spawn_item(item: InventoryItem, pos: Vector2 = Vector2.ZERO, scene: PackedScene = drop_item_scene) -> void:
	item_spawned.emit(item, pos, scene)


func spawn_bomb(item: InventoryBomb, pos: Vector2 = Vector2.ZERO, scene: PackedScene = bomb_item_scene) -> void:
	item_spawned.emit(item, pos, scene)


func spawn_explosion(item: InventoryBomb, pos: Vector2 = Vector2.ZERO, scene: PackedScene = explosion_scene) -> void:
	item_spawned.emit(item, pos, scene)

func spawn_damage_number(damage: Damage, pos: Vector2 = Vector2.ZERO, scene: PackedScene = damage_number_scene) -> void:
	damage_spawned.emit(damage, pos, scene)
