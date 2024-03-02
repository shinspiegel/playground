class_name Conversation extends Node2D

@export var interactable: Interactable
@export_range(0.0, 2.0, 0.1) var colddown: float = 0.3
@export var message_list: Array[MessageData] = []

@onready var timer: Timer = $Timer


func _ready() -> void:
	interactable.interacted.connect(on_interact)
	MessageManager.conversation_finished.connect(on_finish)


func on_interact() -> void:
	if timer.is_stopped():
		MessageManager.start_conversation(message_list)


func on_finish() -> void:
	timer.start()
