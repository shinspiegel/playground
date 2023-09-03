class_name PlayerInventorySelection extends Control

const inventory_item = preload("res://Entities/CraftDefinition/UI_Elements/IngredientButton.tscn")

signal item_selected(node: Control, item: InventoryItem)

@export var item: InventoryItem

@onready var back: Button = %Back
@onready var grid_container: GridContainer = %GridContainer
@onready var item_name: Label = %ItemName
@onready var item_rarity: Label = %ItemRarity
@onready var item_description: Label = %ItemDescription


func _ready() -> void:
	back.pressed.connect(func(): GameManager.close_inventory())
	back.focus_entered.connect(func(): item = null)
	back.grab_focus()
	
	PlayerInput.square_pressed.connect(on_square_press)
	PlayerInput.triangle_pressed.connect(on_triangle_press)
	PlayerInput.circle_pressed.connect(on_circle_press)
	PlayerInput.options_pressed.connect(on_option_pressed)
	
	__clean_grid()
	__update_grid_container()
	__initial_selection()


func on_option_pressed() -> void:
	GameManager.close_inventory()


func on_square_press() -> void:
	if item: PlayerData.set_hotbar(item, PlayerData.HOTBAR.ZERO)


func on_triangle_press() -> void:
	if item: PlayerData.set_hotbar(item, PlayerData.HOTBAR.ONE)


func on_circle_press() -> void:
	if item: PlayerData.set_hotbar(item, PlayerData.HOTBAR.TWO)


func on_item_focus(focused_item: InventoryItem) -> void:
	item = focused_item
	__update_side_text()


func __clean_grid() -> void:
	for child in grid_container.get_children():
		# Need to remove on this frame, 
		# will use the first as the initial selection
		child.free()


func __update_grid_container() -> void:
	for entry in PlayerData.inventory:
		var node = inventory_item.instantiate()
		node.icon = entry.icon
		node.pressed.connect(func(): item_selected.emit(node, entry))
		node.focus_entered.connect(func(): on_item_focus(entry))
		grid_container.add_child(node)


func __initial_selection() -> void:
	if grid_container.get_child_count() > 0 and grid_container.get_child(0) is Control:
		grid_container.get_child(0).grab_focus()
	else:
		back.grab_focus()


func __update_side_text() -> void:
	item_name.text = item.get_item_name()
	item_rarity.text = item.get_type()
	item_description.text = item.get_description()

