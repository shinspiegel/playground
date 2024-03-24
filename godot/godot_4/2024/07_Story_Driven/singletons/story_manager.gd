extends Node

signal story_changed(story: StoryData)

@export var data: StoryData


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

