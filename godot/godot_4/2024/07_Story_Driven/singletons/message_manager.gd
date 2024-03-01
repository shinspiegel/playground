extends Control

signal conversation_finished()

@onready var message: DisplayMessage = %DisplayMessage


func start_conversation(messages: Array[MessageData]) -> void:
	GameManager.change_to_talk()
	print(messages)
	conversation_finished.emit()
	GameManager.change_to_world()

