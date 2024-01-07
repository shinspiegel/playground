@tool
class_name MarkdownTodoPersistData
extends Node

var file: FileAccess
var parser: MarkdownTodoTree


func load() -> void:
	file = FileAccess.open("res://todo.md", FileAccess.READ)
	parser.parse(file.get_as_text())
	file.close()


func save() -> void:
	file = FileAccess.open("res://todo.md", FileAccess.WRITE)
	file.store_string(parser.to_markdown())
	file.close()
