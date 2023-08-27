class_name DropItem extends InteractableObject

@export_group("Drop Item")
@export var player_data: PlayerData = preload("res://Resources/PlayerData/PlayerData.tres")
@export var item: InventoryItem


func _on_interact() -> void:
	player_data.add_to_inventory(item)
	queue_free()


func set_item(value: InventoryItem) -> void:
	item = value
	sprite_2d.texture = value.icon
