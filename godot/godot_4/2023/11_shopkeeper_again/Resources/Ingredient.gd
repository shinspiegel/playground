class_name Ingredient extends InventoryItem

func clone() -> InventoryItem:
	var resource = super.clone()
	print_debug(self)
	return resource
