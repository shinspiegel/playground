@tool class_name CraftRecipeButton extends TextureButton

signal selected()

@onready var check_button: CheckButton = $MarginContainer/HBoxContainer/CheckButton
@onready var texture_rect: TextureRect = $MarginContainer/HBoxContainer/TextureRect
@onready var label: Label = $MarginContainer/HBoxContainer/Label

@export var text: String:
	get: 
		return label.text
	set(t): 
		label.text = t

@export var is_selected: bool:
	get: 
		return check_button.button_pressed
	set(t):
		check_button.button_pressed = t
		if t: selected.emit()

@export var icon: Texture2D:
	get: 
		return texture_rect.texture
	set(t): 
		texture_rect.texture = t


func _ready() -> void:
	pressed.connect(func(): is_selected = !is_selected)
