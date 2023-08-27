extends InteractableObject

@export var destination: String


func _on_interact() -> void:
	SceneManager.change_to(destination)
