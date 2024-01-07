@tool
class_name MarkdownTodoTree
extends Node

signal created(new_todo: MarkdownTodoItem)

func parse(raw_text: String) -> void:
	var current: Node = self
	__clean_tree()

	for line in raw_text.split("\n"):
		if line.is_empty(): continue
		var new_node = create_todo(line)
		current.add_child(new_node)



func to_markdown() -> String:
	var text := ""

	for node in get_children():
		if node is MarkdownTodoItem:
			if node.completed:
				text += "- [x] "
			else:
				text += "- [ ] "

			if node.content.ends_with("]"):
				text += node.content.rsplit("[", false, 1)[0].strip_edges()
			else:
				text += node.content.strip_edges()

			if node.seconds_used > 0:
				var minutes = floori(float(node.seconds_used) / 60)
				var seconds = node.seconds_used - (minutes * 60)

				text += " [%s:%s]" % [str(minutes).lpad(2, "0"), str(seconds).lpad(2, "0")]

			text += "\n"

	return text


func add_new_todo(text: String) -> MarkdownTodoItem:
	var new = create_todo(text)
	add_child(new)
	created.emit(new)
	return new


func create_todo(line: String) -> MarkdownTodoItem:
	var item = MarkdownTodoItem.new()

	item.completed = line.contains("- [x] ")
	item.content = line.lstrip(" ").lstrip("\t").replace("- [ ] ", "").replace("- [x] ", "").strip_edges()
	item.seconds_used = __get_time_from_message(line)

	return item


func __clean_tree() -> void:
	for child in get_children():
		remove_child(child)
		child.queue_free()


func __get_time_from_message(line: String) -> int:
	var minutes: int = 0
	var seconds: int = 0

	if line.ends_with("]"):
		var cleaned: String = line.replace("- [ ] ", "").replace("- [x] ", "")
		var time_string: String = cleaned.substr(cleaned.find("[")+1, 5)
		minutes = time_string.split(":")[0].to_int()
		seconds = time_string.split(":")[1].to_int()

	return (minutes*60) + seconds
