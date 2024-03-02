extends CanvasLayer

signal conversation_finished()

@onready var display_message: DisplayMessage = %DisplayMessage

var list: Array[MessageData] = []
var index: int = 0


func _ready() -> void:
	display_message.message_ended.connect(on_message_end)
	display_message.hide()


func start_conversation(messages: Array[MessageData]) -> void:
	GameManager.change_to_talk()
	reset()

	list.append_array(messages)

	display_message.show()
	display_message.prepare()
	await display_message.prepared

	next_message()


func next_message() -> void:
	display_message.display(list[index])


func reset() -> void:
	index = 0
	list = []


func on_message_end() -> void:
	index += 1

	if index < list.size():
		next_message()
		return

	conversation_finished.emit()
	display_message.unprepare()

	print("started")
	await display_message.unprepared
	print("ended")

	display_message.hide()
	GameManager.change_to_world()

