class_name IngredientItem extends SelectableItem

@export var ingredient: IngredientBase


func set_resource(res: IngredientBase) -> void:
	ingredient = res
	set_data(ingredient.title, ingredient.image)
