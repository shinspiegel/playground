class_name CutSceneStepTalk extends CutSceneBase

@export var messages: Array[MessageData]


func execute() -> void:
	MessageManager.start(messages)
	await MessageManager.ended
	ended.emit()
