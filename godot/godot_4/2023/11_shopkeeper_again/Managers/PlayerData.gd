extends Node

enum HOTBAR { ZERO, ONE, TWO }

signal health_changed()
signal inventory_changed()
signal hotbar_changed()

@export_group("Health", "health_")
@export var health_max: int = 20
@export var health_current: int = 20

@export_group("Stats", "stat_")
@export var stat_speed: float = 500.0

@export_group("Hot Bar", "hotbar_")
@export var hotbar_zero: InventoryItem
@export var hotbar_one: InventoryItem
@export var hotbar_two: InventoryItem

@export_group("Inventory")
@export var inventory: Array[InventoryItem] = []


func change_health_by(value: int) -> void:
	health_current = clampi(health_current + value, 0, health_max)
	health_changed.emit()


func add_to_inventory(item: InventoryItem) -> void:
	inventory.append(item)
	__auto_update_hotbar(item)
	inventory_changed.emit()


func destroy_item(item: InventoryItem) -> void:
	inventory.erase(item)
	
	if hotbar_zero == item: hotbar_zero = null
	if hotbar_one == item: hotbar_one = null
	if hotbar_two == item: hotbar_two = null
	
	inventory_changed.emit()
	hotbar_changed.emit()


func set_hotbar(item: InventoryItem, slot: HOTBAR) -> void:
	match slot:
		HOTBAR.ZERO: hotbar_zero = item
		HOTBAR.ONE: hotbar_one = item
		HOTBAR.TWO: hotbar_two = item
	
	hotbar_changed.emit()


func use_hotbar_item(slot: HOTBAR, pos: Vector2 = Vector2.ZERO) -> void:
	var item: InventoryItem
	
	match slot:
		HOTBAR.ZERO: item = hotbar_zero
		HOTBAR.ONE: item = hotbar_one
		HOTBAR.TWO: item = hotbar_two
	
	if item:
		if item is InventoryBomb:
			GameManager.spawn_bomb(item, pos)
			destroy_item(item)
		elif item is InventoryPotion:
			__use_potion_resource(item)
			destroy_item(item)
		elif item is InventoryItem:
			GameManager.spawn_item(item, pos)
			destroy_item(item)


func __auto_update_hotbar(item: InventoryItem) -> void:
	if not hotbar_zero: 
		set_hotbar(item, HOTBAR.ZERO) 
	elif not hotbar_one: 
		set_hotbar(item, HOTBAR.ONE)
	elif not hotbar_two: 
		set_hotbar(item, HOTBAR.TWO)


func __use_potion_resource(item: InventoryPotion) -> void:
	print("Potion used::[%s]" % [item])
