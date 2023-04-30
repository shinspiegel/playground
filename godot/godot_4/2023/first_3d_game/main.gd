extends Node3D

@onready var interactable: Interactable = $NPC/Interactable

func _ready() -> void:
	interactable.interacted.connect(func(): print("Thing!"))
