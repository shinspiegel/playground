extends Node

const recipes = [
	preload("res://Resources/Recipes/Bomb.tres"),
	preload("res://Resources/Recipes/QuickBomb.tres"),
	preload("res://Resources/Recipes/Potion.tres"),
	preload("res://Resources/Recipes/SlowPotion.tres"),
]

const INGREDIENTS = {
	"coal": preload("res://Resources/Ingredients/Coal.tres"), 
	"cristal": preload("res://Resources/Ingredients/Cristal.tres"), 
	"wood": preload("res://Resources/Ingredients/Wood.tres")
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
