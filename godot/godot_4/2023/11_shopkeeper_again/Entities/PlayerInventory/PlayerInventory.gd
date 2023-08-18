extends Control

@onready var inventory_selection: PlayerInventorySelection = $InventorySelection
@onready var item_selected: PlayerInventorySelected = $ItemSelected
@onready var add_hotbar: PlayerInventoryAddHotbar = $AddHotbar


func _ready() -> void:
	inventory_selection.item_selected.connect(on_inventory_select)
	
	item_selected.canceled.connect(on_item_selected_cancel)
	item_selected.hot_bar_pressed.connect(on_hot_bar_pressed)
	
	add_hotbar.canceled.connect(on_hotbar_cancel)


func _draw() -> void:
	inventory_selection.show()
	item_selected.hide()
	add_hotbar.hide()


func on_inventory_select(_node: Control, item: InventoryItem) -> void:
	item_selected.set_item(item)
	add_hotbar.set_item(item)
	
	inventory_selection.hide()
	item_selected.show()
	add_hotbar.hide()


func on_item_selected_cancel() -> void:
	inventory_selection.show()
	item_selected.hide()
	add_hotbar.hide()


func on_hot_bar_pressed() -> void:
	inventory_selection.hide()
	item_selected.hide()
	add_hotbar.show()


func on_hotbar_cancel() -> void:
	inventory_selection.hide()
	item_selected.show()
	add_hotbar.hide()
