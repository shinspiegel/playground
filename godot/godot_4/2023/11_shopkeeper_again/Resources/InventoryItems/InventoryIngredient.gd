class_name InventoryIngredient extends InventoryItem

@export_group("Ingredient")
@export var possible_bonus: Array[BonusEffect] = []


func get_type() -> String: 
	return "%s Ingredient" % [__get_rarity_name()]


func get_description() -> String:
	return "This is a ingredient."
