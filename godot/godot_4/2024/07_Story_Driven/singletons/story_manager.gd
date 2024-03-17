extends Node

@export var data: StoryData


func get_data() -> StoryData:
	return data


func get_chapter() -> int: 
	return get_data().chapter


func get_episode() -> int: 
	return get_data().episode


func get_step() -> int: 
	return get_data().step


func advance_chapter() -> void:
	data.chapter += 1
	data.episode = 0
	data.step = 0
	advance_episode()


func advance_episode() -> void:
	data.episode += 1


func set_step(step: int) -> void:
	data.step = step



