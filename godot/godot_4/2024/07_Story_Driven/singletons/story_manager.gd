extends Node

const data = preload("res://singletons/story_data.tres")
const jakub_profile = preload("res://scenes/display_message/profiles/jakub_profile.tres")

signal story_changed(story: StoryData)

var bubble_message_list: Array[MessageData] = []

var messages = [
	[], # Chapter 0
	[], # Chapter 1
	[], # Chapter 2
]


func _ready() -> void:
	read_from_csv("res://dialogs/chapter_0.csv", messages[0])
	read_from_csv("res://dialogs/message_bubble.csv", messages[1])


func message_at(chapter: int, index: int) -> MessageData:
	if index >= messages[chapter].size():
		push_warning("Out of bounds message")
		return MessageData.new()

	return messages[chapter][index]


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


func read_from_csv(filepath: String, list: Array[MessageData]) -> void:
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
			match line[1]:
				"1": msg.profile = jakub_profile
				_: pass

		if line.size() > 2:
			msg.speed_ratio = line[2].to_float()

		if line.size() > 3:
			msg.duration = line[3].to_float()

		if line.size() > 4:
			msg.weight = line[4].to_float()

		list.append(msg)

	file.close()

