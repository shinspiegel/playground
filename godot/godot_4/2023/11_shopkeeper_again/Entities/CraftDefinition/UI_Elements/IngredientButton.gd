@tool class_name IngredientButton extends TextureButton

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@export var icon: Texture2D

func _ready() -> void:
	texture_rect.texture = icon
