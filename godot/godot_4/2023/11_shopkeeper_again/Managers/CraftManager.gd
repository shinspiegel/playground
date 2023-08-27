extends Node

const recipes = [
	preload("res://Resources/Recipes/RecipesList/Bomb.tres"),
	preload("res://Resources/Recipes/RecipesList/QuickBomb.tres"),
	preload("res://Resources/Recipes/RecipesList/Potion.tres"),
	preload("res://Resources/Recipes/RecipesList/SlowPotion.tres"),
]

const INGREDIENTS = {
	"coal": preload("res://Resources/InventoryItems/Ingredients/Coal.tres"), 
	"cristal": preload("res://Resources/InventoryItems/Ingredients/Cristal.tres"), 
	"wood": preload("res://Resources/InventoryItems/Ingredients/Wood.tres"),
}

signal started()
signal ended()
signal recipe_changed(recipe: Recipe)

@export var craft_definition: CraftDefinitionEntry


func init_craft() -> void:
	started.emit()


func cancel_craft() -> void:
	ended.emit()


func get_recipe_list() -> Array[Recipe]:
	var list: Array[Recipe] = []
	
	for item in recipes:
		if item is Recipe and item.discovered:
			list.append(item)
	
	return list


func select_recipe(value: Recipe) -> void:
	if recipes.has(value):
		craft_definition.set_recipe(value)
		recipe_changed.emit(value)


func get_current_recipe() -> Recipe:
	return craft_definition.recipe
