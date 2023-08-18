class_name CraftDefinition extends Control

const recipe_button = preload("res://Entities/CraftDefinition/UI_Elements/CraftRecipeButton.tscn")
const ingredient_button = preload("res://Entities/CraftDefinition/UI_Elements/IngredientButton.tscn")

@onready var recipes_box: VBoxContainer = $HBoxContainer/VBoxContainer2/ScrollContainer/RecipesBox
@onready var inventory_grid: GridContainer = $HBoxContainer/VBoxContainer3/ScrollContainer2/InventoryGrid


func _ready() -> void:
	draw.connect(start_craft_definition)
	CraftManager.recipe_changed.connect(on_recipe_change)


func start_craft_definition() -> void:
	__remove_recipes_children()
	__add_recipes()
	__select_first_recipe()



func on_recipe_change(current: Recipe) -> void:
	for entry in recipes_box.get_children():
		if entry is CraftRecipeButton and entry.recipe == current:
			entry.set_is_selected(true)
		else:
			entry.set_is_selected(false)


func __remove_recipes_children() -> void:
	for child in recipes_box.get_children():
		# Need to remove on this frame,
		# since it will use the first for the default selection
		child.free()


func __add_recipes() -> void:
	for recipe in CraftManager.get_recipe_list():
		var node: CraftRecipeButton = recipe_button.instantiate()
		node.recipe = recipe
		node.text = recipe.recipe_name
		node.icon = recipe.icon
		node.is_selected = false
		recipes_box.add_child(node)


func __select_first_recipe() -> void:
	if recipes_box.get_child_count() > 0:
		var first = recipes_box.get_child(0)
		if first is Control:
			first.grab_focus()

