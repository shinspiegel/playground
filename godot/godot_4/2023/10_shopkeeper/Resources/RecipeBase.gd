class_name RecipeBase extends InventoryItem

@export_enum("Potion", "Bomb") var type: String
@export var success_required: int = 3
@export var fail_limit: int = 2
