@tool class_name CraftRecipeButton extends TextureButton

signal selected()

@onready var check_button: CheckButton = $MarginContainer/HBoxContainer/CheckButton
@onready var texture_rect: TextureRect = $MarginContainer/HBoxContainer/TextureRect
@onready var label: Label = $MarginContainer/HBoxContainer/Label

@export var text: String
@export var is_selected: bool
@export var icon: Texture2D


func _ready() -> void:
	label.text = text
	texture_rect.texture = icon
	check_button.button_pressed = is_selected
	pressed.connect(on_press)


func on_press() -> void:
	check_button.button_pressed = !check_button.button_pressed


func set_is_selected(value: bool) -> void:
	is_selected = value
	check_button.button_pressed = value
