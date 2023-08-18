class_name PlayerInventorySelection extends VBoxContainer

const inventory_item = preload("res://Entities/CraftDefinition/UI_Elements/IngredientButton.tscn")

signal item_selected(node: Control, item: InventoryItem)

@export var player_data: PlayerData

@onready var back: Button = $Back
@onready var grid_container: GridContainer = $ScrollContainer/MarginContainer/GridContainer


func _ready() -> void:
	back.pressed.connect(func(): GameManager.close_inventory())


func _draw() -> void:
	back.grab_focus()
	__clean_grid()
	__update_grid_container()
	__initial_selection()


func __clean_grid() -> void:
	for child in grid_container.get_children():
		# Need to remove on this frame, 
		# will use the first as the initial selection
		child.free()


func __update_grid_container() -> void:
	for entry in player_data.inventory:
		var node = inventory_item.instantiate()
		node.icon = entry.icon
		node.pressed.connect(func(): item_selected.emit(node, entry))
		grid_container.add_child(node)


func __initial_selection() -> void:
	if grid_container.get_child_count() > 0 and grid_container.get_child(0) is Control:
		grid_container.get_child(0).grab_focus()
	else:
		back.grab_focus()
