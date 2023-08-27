class_name ExplosiveItem extends InteractableObject

@export_group("Explosive Item")
@export var player_data: PlayerData = preload("res://Resources/PlayerData/PlayerData.tres")
@export var item: InventoryBomb

@onready var timer: Timer = $Timer


func _ready() -> void:
	super._ready()
	timer.timeout.connect(on_timeout)


func _on_interact() -> void:
	player_data.add_to_inventory(item)
	queue_free()


func set_item(value: InventoryBomb) -> void:
	item = value
	sprite_2d.texture = value.icon
	timer.start(value.time_to_explode)


func on_timeout() -> void:
	print_debug("Spawn explosion")
	queue_free()
