class_name PlayerInventorySelected extends VBoxContainer

signal canceled()
signal dropped_item(item: InventoryItem)

@export var player_data: PlayerData
@export var item: InventoryItem

@onready var selected_texture: TextureRect = $SelectedTexture
@onready var drop: Button = $Drop
@onready var destroy: Button = $Destroy
@onready var back_inventory: Button = $BackInventory


func _ready() -> void:
	drop.pressed.connect(on_drop)
	destroy.pressed.connect(on_destroy_item)
	back_inventory.pressed.connect(on_back_press)
	PlayerInput.circle_pressed.connect(on_back_press)
	
	selected_texture.texture = item.icon
	back_inventory.grab_focus()


func set_item(value: InventoryItem) -> void:
	item = value


func on_drop() -> void:
	dropped_item.emit(item)
	player_data.destroy_item(item)
	GameManager.close_inventory()


func on_destroy_item() -> void:
	player_data.destroy_item(item)
	canceled.emit()


func on_back_press() -> void:
	if visible:
		canceled.emit()
