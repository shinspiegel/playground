class_name PlayerData extends Resource

enum HOTBAR { zero, one, two }

signal health_changed()
signal inventory_changed()
signal hotbar_changed()

@export_group("Health", "health_")
@export var health_max: int = 20
@export var health_current: int = 20

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
		HOTBAR.zero: hotbar_zero = item
		HOTBAR.one: hotbar_one = item
		HOTBAR.two: hotbar_two = item
	
	hotbar_changed.emit()


func use_hotbar_item(slot: HOTBAR, pos: Vector2 = Vector2.ZERO) -> void:
	var item: InventoryItem
	
	match slot:
		HOTBAR.zero: item = hotbar_zero
		HOTBAR.one: item = hotbar_one
		HOTBAR.two: item = hotbar_two
	
	if item:
		if item is InventoryItem:
			GameManager.spawn_item(item, pos)
			destroy_item(item)


func __auto_update_hotbar(item: InventoryItem) -> void:
	if not hotbar_zero: return set_hotbar(item, HOTBAR.zero) 
	if not hotbar_one: return set_hotbar(item, HOTBAR.one)
	if not hotbar_two: return set_hotbar(item, HOTBAR.two)
