class_name Conversation extends Node2D

@export var interactable: Interactable
@export var message_list: Array[MessageData] = []


func _ready() -> void:
	interactable.interacted.connect(on_interact)


func on_interact() -> void:
	MessageManager.start_conversation(message_list)
