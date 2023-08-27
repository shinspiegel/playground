class_name CraftDefinitionEntry extends Resource

@export var recipe: Recipe
@export var ingredients: Array[InventoryIngredient] = []


func get_recipe() -> Recipe:
	return recipe


func set_recipe(value: Recipe) -> void:
	recipe = value
