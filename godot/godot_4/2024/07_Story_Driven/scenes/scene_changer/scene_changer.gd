class_name SceneChanger extends Node

@export var scene: String
@export var interactable: Interactable


func _ready() -> void:
	interactable.interacted.connect(on_interact)


func on_interact() -> void:
	SceneManager.change_to_file(scene)
