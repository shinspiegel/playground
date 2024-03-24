extends CanvasLayer

const BUBBLE_MESSAGE = preload("res://scenes/bubble_message/bubble_message.tscn")

signal started()
signal ended()

@onready var display_message: DisplayMessage = %DisplayMessage

var list: Array[MessageData] = []
var step_index: int = 0
var regex = RegEx.new()


func _ready() -> void:
	regex.compile("\\[\\/?[^\\]]*\\]")
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


func create_bubble(target_node: Node, message_data: MessageData, global_position: Vector2 = Vector2.ZERO) -> void:
	var msg: BubbleMessage = BUBBLE_MESSAGE.instantiate()
	msg.message_data = message_data
	target_node.add_child(msg)
	msg.global_position = global_position



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

	# Should never happen, still keep it here
	return weight_list[0]


func next_message() -> void:
	display_message.display(list[step_index])


func reset() -> void:
	step_index = 0
	list = []


func remove_bbcode(text: String) -> String:
	var words = regex.search_all(text)

	for word in words:
		var bb_code = word.get_string()
		text = text.replace(bb_code, "")

	return text


func on_message_end() -> void:
	step_index += 1

	if step_index < list.size():
		next_message()
		return

	display_message.unprepare()

	await display_message.unprepared

	display_message.hide()
	ended.emit()

