extends Control

@onready var inventory: Button = $VBoxContainer/Inventory
@onready var back: Button = $VBoxContainer/Back


func _ready() -> void:
	back.pressed.connect(func(): GameManager.close_inventory())


func _draw() -> void:
	inventory.grab_focus()
