class_name CraftManager extends Node

@export_subgroup("player")
@export var recipes_know: Array[RecipeBase]
@export var inventory: Array[InventoryItem]

@export_subgroup("craft_selection")
@export var current_recipe: RecipeBase
@export var selected_ingredients: Array[IngredientBase] = []
@export var craft_entry: CraftEntry


func generate_craft_entry() -> void:
	craft_entry = CraftEntry.new()
	craft_entry.apply_recipe(current_recipe)
	craft_entry.apply_ingredients(selected_ingredients)
