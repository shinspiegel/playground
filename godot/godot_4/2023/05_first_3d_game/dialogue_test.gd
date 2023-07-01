extends Node

@export var interactable_path: NodePath
@export var dialogue: DialogueList

var _interactable: Interactable

func _ready() -> void:
	_interactable = get_node(interactable_path)
	_interactable.interacted.connect(on_interact)


func on_interact() -> void:
	TextMessage.start_dialogue(dialogue)
