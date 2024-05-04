class_name DamageText extends Node2D

@export var text: String = "Blocked"
@onready var text_label: Label = %Text


func _ready() -> void:
	text_label.text = text
