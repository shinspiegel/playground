class_name CutSceneTalk extends CutSceneBase

@export var chapter: int = 0
@export var messages: Array[int]


func execute() -> void:
	MessageManager.start(StoryManager.message_list(chapter, messages))
	await MessageManager.ended
	ended.emit()
