class_name DropItem extends InteractableObject

@export_group("Drop Item")
@export var item: InventoryItem
@export var power: float = 300

func _on_interact() -> void:
	PlayerData.add_to_inventory(item)
	queue_free()


func set_item(value: InventoryItem) -> void:
	item = value
	sprite_2d.texture = value.icon
