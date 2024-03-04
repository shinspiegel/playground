class_name CutSceneStepTalk extends CutSceneStep

@export var messages: Array[MessageData]


func execute() -> void:
	MessageManager.start(messages)

	if wait_for_next:
		await MessageManager.ended
		ended.emit()

