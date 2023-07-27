class_name RecipeItem extends SelectableItem

@export var recipe: RecipeBase


func set_resource(res: RecipeBase) -> void:
	recipe = res
	set_data(recipe.title, recipe.image)
