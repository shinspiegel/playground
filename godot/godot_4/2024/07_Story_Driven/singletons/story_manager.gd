extends Node

signal story_changed()
signal chapter_changed(chapter: int)
signal episode_changed(episode: int)
signal step_changed(step: int)

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
	chapter_changed.emit(data.chapter)
	story_changed.emit()


func advance_episode() -> void:
	data.episode += 1
	episode_changed.emit(data.episode)
	story_changed.emit()


func set_step(step: int) -> void:
	data.step = step
	step_changed.emit(data.step)
	story_changed.emit()



