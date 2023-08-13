extends InteractableObject

@export var destination: String


func on_interact() -> void:
	SceneManager.change_to(destination)
