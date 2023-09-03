class_name InventoryPotion extends InventoryItem

@export_group("Potion")
@export var effects: Array[BonusEffect] = []


func get_type() -> String: 
	return "%s Potion" % [__get_rarity_name()]


func get_description() -> String:
	return "This is a potion."
