class_name StaticItem extends StaticBody2D
 
@export var interactable: Interactable
@onready var sprite: OutlinedSprite = %OutlinedSprite


func _ready() -> void:
	if interactable:
		interactable.focus.connect(func(): sprite.enable())
		interactable.blur.connect(func(): sprite.disable())

