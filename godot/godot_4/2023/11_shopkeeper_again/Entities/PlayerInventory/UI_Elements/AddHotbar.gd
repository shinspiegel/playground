class_name PlayerInventoryAddHotbar extends VBoxContainer

signal canceled()
signal hotbar_selected()

@export var player_data: PlayerData
@export var item: InventoryItem

@onready var button_add_1: Button = $HBoxContainer/ButtonAdd1
@onready var button_add_2: Button = $HBoxContainer/ButtonAdd2
@onready var button_add_3: Button = $HBoxContainer/ButtonAdd3
@onready var back_selected: Button = $BackSelected


func _ready() -> void:
	button_add_1.pressed.connect(on_select_zero)
	PlayerInput.square_pressed.connect(on_select_zero)
	
	button_add_2.pressed.connect(on_select_one)
	PlayerInput.triangle_pressed.connect(on_select_one)
	
	button_add_3.pressed.connect(on_select_two)
	PlayerInput.circle_pressed.connect(on_select_two)
	
	back_selected.pressed.connect(func(): canceled.emit())


func _draw() -> void:
	back_selected.grab_focus()


func set_item(value: InventoryItem) -> void:
	item = value


func on_select_zero() -> void:
	if visible:
		player_data.set_hotbar(item, PlayerData.HOTBAR.zero)
		hotbar_selected.emit()


func on_select_one() -> void:
	if visible:
		player_data.set_hotbar(item, PlayerData.HOTBAR.one)
		hotbar_selected.emit()


func on_select_two() -> void:
	if visible:
		player_data.set_hotbar(item, PlayerData.HOTBAR.two)
		hotbar_selected.emit()
