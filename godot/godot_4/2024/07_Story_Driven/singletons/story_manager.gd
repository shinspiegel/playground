extends Node

const data = preload("res://singletons/story_data.tres")
const jakub_profile = preload("res://scenes/display_message/profiles/jakub_profile.tres")

signal story_changed(story: StoryData)

var bubble_message_list: Array[MessageData] = []
var chapter_0: Array[MessageData] = []
var chapter_1: Array[MessageData] = []


func _ready() -> void:
	data.changed.connect(func(): story_changed.emit(data))
	read_from_csv(0, "res://dialogs/chapter_0.csv", chapter_0)
	read_from_csv(1, "res://dialogs/chapter_1.csv", chapter_1)


func message_list(chapter: int, index_list: Array[int]) -> Array[MessageData]:
	var list: Array[MessageData] = []

	for index in index_list:
		list.append(message_from(chapter, index))

	return list


func message_from(chapter: int, index: int) -> MessageData:
	var list: Array[MessageData]

	match chapter:
		0: list = chapter_0
		1: list = chapter_1
		_: pass

	if index >= list.size():
		push_error("Out of bounds message")
		return MessageData.new()

	return list[index]


func advance_chapter() -> void:
	data.chapter += 1
	data.episode = 0
	data.step = 0
	story_changed.emit(data)


func read_from_csv(chapter: int, filepath: String, list: Array[MessageData]) -> void:
	var file := FileAccess.open(filepath, FileAccess.READ)
	var line_number := 1 # Line count starts from 1

	if file == null:
		push_error("failed to open file %s" % [filepath])
		return

	# Fetch headers
	file.get_csv_line()

	while not file.eof_reached():
		var line := file.get_csv_line()
		line_number += 1

		var msg := MessageData.new()

		if line.size() <= 0 or line[0].is_empty():
			continue

		if line.size() > 0:
			msg.text = line[0]

		if line.size() > 1:
			match line[1].to_int():
				0: msg.profile = jakub_profile
				_: pass

		if line.size() > 2 and not line[2].is_empty():
			msg.speed_ratio = line[2].to_float()

		if line.size() > 3 and not line[3].is_empty():
			msg.duration = line[3].to_float()

		if line.size() > 4 and not line[4].is_empty():
			msg.weight = line[4].to_float()

		if line.size() > 5 and not line[5].is_empty():
			msg.option_a = line[5]

		if line.size() > 6 and not line[6].is_empty():
			msg.option_b = line[6]

		if line.size() > 7 and not line[7].is_empty():
			msg.option_c = line[7]

		msg.id = "%s_%s" % [chapter, line_number]
		list.append(msg)

	file.close()

