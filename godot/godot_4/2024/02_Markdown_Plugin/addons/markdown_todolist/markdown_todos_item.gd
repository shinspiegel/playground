@tool
class_name MarkdownTodoItem
extends Node

signal changed()
signal deleted()

@export var content: String = ""
@export var completed: bool = false
@export var seconds_used: int = 0


func get_content() -> String:
	return content


func set_content(value: String) -> void:
	content = value
	changed.emit()


func get_completed() -> bool:
	return completed


func set_completed(value: bool) -> void:
	completed = value
	changed.emit()


func get_used_seconds() -> int:
	return seconds_used


func set_used_seconds(value: int) -> void:
	seconds_used = value

	if value > 0:
		if content.ends_with("]"):
			content = content.rsplit("[", false, 1)[0].strip_edges()

		var minutes = floori(float(value) / 60)
		var seconds = value - (minutes * 60)
		content += " [%s:%s]" % [str(minutes).lpad(2,"0"), str(seconds).lpad(2,"0")]

	changed.emit()


func delete_item() -> void:
	deleted.emit()
	queue_free()

