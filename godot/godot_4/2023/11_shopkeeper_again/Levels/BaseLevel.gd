class_name BaseLevel extends Node2D

@onready var player_inventory: Control = $Overlay/PlayerInventory
@onready var sorted_object: Node2D = $SortedObject
@onready var background: Control = $Overlay/Background


func _ready() -> void:
	player_inventory.hide()
	background.hide()
	GameManager.inventory_opened.connect(on_inventory_opened)
	GameManager.inventory_closed.connect(on_inventory_closed)


func on_inventory_opened() -> void:
	sorted_object.set_deferred("process_mode", PROCESS_MODE_DISABLED)
	background.show()
	player_inventory.show()


func on_inventory_closed() -> void:
	player_inventory.hide()
	background.hide()
	sorted_object.set_deferred("process_mode", PROCESS_MODE_INHERIT)
