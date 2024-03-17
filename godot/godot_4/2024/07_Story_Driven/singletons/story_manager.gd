extends Node

@export var data: StoryData


func advance_chapter() -> void:
	data.chapter += 1
	data.episode = 0
	data.step = 0
	advance_episode()


func advance_episode() -> void:
	data.episode += 1


func set_step(step: int) -> void:
	data.step = step



