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


func create_bubble_at(actor: Actor, message_data: MessageData) -> void:
	var msg: BubbleMessage = BUBBLE_MESSAGE.instantiate()
	msg.message_data = message_data
	actor.add_child(msg)
	msg.global_position = actor.message_pos.global_position


func random_bubble_weighted(weight_list: Array[MessageData]) -> MessageData:
	var total: float = 0.0
	var cursor: float = 0.0
	var rand_weight: float = 0.0

	for data in weight_list:
		total += data.weight

	rand_weight = randf_range(0.0, total)

	for item in weight_list:
		cursor += item.weight

		if cursor >= rand_weight:
			return item

	# In case of some failure will return the sorted entry
	return weight_list[0]


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

