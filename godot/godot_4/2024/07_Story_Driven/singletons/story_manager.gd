extends Node

signal story_changed(story: StoryData)

@export var data: StoryData

var bubble_message_list: Array[MessageData] = []

var messages = [
	[], # Chapter 0
	[], # Chapter 1
	[], # Chapter 2
]


func _ready() -> void:
	__read_bubble_message_csv("res://dialogs/message_bubble.csv", bubble_message_list)


func message_at(index: int) -> MessageData:
	if index >= bubble_message_list.size():
		push_warning("Out of bounds message")
		return MessageData.new()

	return bubble_message_list[index]


func get_chapter() -> int: 
	return data.chapter


func get_episode() -> int: 
	return data.episode


func get_step() -> int: 
	return data.step


func advance_chapter() -> void:
	data.chapter += 1
	data.episode = 0
	data.step = 0
	story_changed.emit(data)


func advance_episode() -> void:
	data.episode += 1
	story_changed.emit(data)


func set_step(step: int) -> void:
	data.step = step
	story_changed.emit(data)


func __read_bubble_message_csv(filepath: String, list: Array[MessageData]) -> void:
	var file = FileAccess.open(filepath, FileAccess.READ)

	# Fetch headers
	file.get_csv_line()


	while not file.eof_reached():
		var line := file.get_csv_line()
		var msg: MessageData = MessageData.new()

		if line.size() <= 0 or line[0].is_empty():
			continue

		if line.size() > 0:
			msg.text = line[0]

		if line.size() > 1:
			# Should I use id for something?
			pass

		if line.size() > 2:
			msg.speed_ratio = line[2].to_float()

		list.append(msg)

	file.close()

