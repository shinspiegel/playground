extends InteractableItem

@export var target_map: String


func on_interacted() -> void:
	GameManager.scenes.change_to(target_map)
