extends CanvasLayer

const BUBBLE_MESSAGE = preload("res://scenes/bubble_message/bubble_message.tscn")

signal started()
signal ended()

@onready var display_message: DisplayMessage = %DisplayMessage

var list: Array[MessageData] = []
var index: int = 0


func _ready() -> void:
	display_message.message_ended.connect(on_message_end)
	display_message.hide()


func start(messages: Array[MessageData]) -> void:
	reset()

	list.append_array(messages)
	started.emit()

	display_message.show()
	display_message.prepare()
	await display_message.prepared

	next_message()


func create_bubble_at(actor: Actor, text: String) -> void:
	var msg: BubbleMessage = BUBBLE_MESSAGE.instantiate()
	msg.text = text
	actor.add_child(msg)
	msg.global_position = actor.message_pos.global_position


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

	display_message.unprepare()

	await display_message.unprepared

	display_message.hide()
	ended.emit()

