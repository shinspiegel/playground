class_name CraftManager extends Node

@export var recipes_know: Array[RecipeBase]
@export var inventory: Array[InventoryItem]
@export var craft_entry: CraftEntry


func generate_craft_entry(recipe: RecipeBase, ingredients: Array[InventoryItem]) -> void:
	pass
