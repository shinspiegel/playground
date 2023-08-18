class_name PlayerInventoryAddHotbar extends VBoxContainer

signal canceled()

@export var player_data: PlayerData
@export var item: InventoryItem

@onready var button_add_1: Button = $HBoxContainer/ButtonAdd1
@onready var button_add_2: Button = $HBoxContainer/ButtonAdd2
@onready var button_add_3: Button = $HBoxContainer/ButtonAdd3
@onready var back_selected: Button = $BackSelected


func _ready() -> void:
	button_add_1.pressed.connect(func(): on_slot_select(PlayerData.HOTBAR.zero))
	button_add_2.pressed.connect(func(): on_slot_select(PlayerData.HOTBAR.one))
	button_add_3.pressed.connect(func(): on_slot_select(PlayerData.HOTBAR.two))
	back_selected.pressed.connect(func(): canceled.emit())


func _draw() -> void:
	back_selected.grab_focus()


func set_item(value: InventoryItem) -> void:
	item = value


func on_slot_select(slot: int) -> void:
	player_data.set_hotbar(item, slot)
	canceled.emit()
