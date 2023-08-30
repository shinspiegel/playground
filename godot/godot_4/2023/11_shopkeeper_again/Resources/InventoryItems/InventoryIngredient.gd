class_name InventoryIngredient extends InventoryItem

@export_group("Ingredient")
@export var possible_bonus: Array[BonusEffect] = []

var __bonus_effect: Array[BonusEffect]
