class_name DropItem extends InteractableObject

@export var player_data: PlayerData = preload("res://Resources/PlayerData/PlayerData.tres")
@export var default_sprite: Texture2D
@export var item: InventoryItem


func _ready() -> void:
	super._ready()
	__set_sprite()


func set_item(value: InventoryItem) -> void:
	item = value
	__set_sprite()


func on_interact() -> void:
	player_data.add_to_inventory(item)
	queue_free()


func __set_sprite() -> void:
	if item:
		sprite_2d.texture = item.icon
	else:
		sprite_2d.texture = default_sprite
