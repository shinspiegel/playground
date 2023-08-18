class_name PlayerInventorySelected extends VBoxContainer

signal canceled()
signal hot_bar_pressed()

@export var player_data: PlayerData
@export var item: InventoryItem

@onready var selected_texture: TextureRect = $SelectedTexture
@onready var add_hot_bar: Button = $AddHotBar
@onready var drop: Button = $Drop
@onready var destroy: Button = $Destroy
@onready var back_inventory: Button = $BackInventory


func _ready() -> void:
	add_hot_bar.pressed.connect(func(): hot_bar_pressed.emit())
	drop.pressed.connect(func(): print(self))
	destroy.pressed.connect(on_destroy_item)
	back_inventory.pressed.connect(on_back_press)
	PlayerInput.circle_pressed.connect(on_back_press)


func _draw() -> void:
	selected_texture.texture = item.icon
	add_hot_bar.grab_focus()


func set_item(value: InventoryItem) -> void:
	item = value


func on_destroy_item() -> void:
	player_data.destroy_item(item)
	canceled.emit()


func on_back_press() -> void:
	if visible:
		canceled.emit()
