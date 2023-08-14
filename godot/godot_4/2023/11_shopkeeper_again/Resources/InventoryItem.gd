class_name InventoryItem extends Resource

enum RARITY {common, uncommon, rare}

@export var item_name: String
@export var icon: Texture2D
@export_enum("common", "uncommon", "rare") var rarity: int
