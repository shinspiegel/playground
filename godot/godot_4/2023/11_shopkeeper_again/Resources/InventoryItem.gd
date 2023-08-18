class_name InventoryItem extends Resource

enum RARITY {common, uncommon, rare}

@export var item_name: String
@export var icon: Texture2D
@export_enum("common", "uncommon", "rare") var rarity: int


func clone() -> InventoryItem:
	var resource = InventoryItem.new()
	
	resource.item_name = item_name
	resource.icon = icon
	resource.rarity = rarity
	
	print_debug(self)
	return resource
