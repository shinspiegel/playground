class_name Door extends StaticBody3D

@export var area_name: String = ""
@onready var interactable: Interactable = $Interactable


func _ready() -> void:
	interactable.interacted.connect(on_interact)


func on_interact() -> void:
	AreaPreloaded.change_by_name(area_name)
