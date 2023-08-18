class_name PlayerData extends Resource

enum HOTBAR {zero, one, two}

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


func destroy_item(item: InventoryItem) -> void:
	inventory.erase(item)
	inventory_changed.emit()


func set_hotbar(item: InventoryItem, slot: HOTBAR) -> void:
	match slot:
		HOTBAR.zero: hotbar_zero = item
		HOTBAR.one: hotbar_one = item
		HOTBAR.two: hotbar_two = item
	
	hotbar_changed.emit()
