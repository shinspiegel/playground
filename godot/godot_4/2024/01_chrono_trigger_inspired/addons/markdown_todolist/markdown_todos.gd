@tool
class_name MarkdownTodos
extends Control

const ui_item = preload("res://addons/markdown_todolist/markdown_ui_item.tscn")

@onready var persist: MarkdownTodoPersistData = %PersistData
@onready var parser: MarkdownTodoTree = %MarkdownParser
@onready var new_entry_text_edit: MarkdownUITextEdit = %NewEntryTextEdit
@onready var box: VBoxContainer = %Box
@onready var reload: Button = $VBoxContainer2/Reload


func _ready() -> void:
	persist.parser = parser
	new_entry_text_edit.returned.connect(on_new_entry)
	reload.pressed.connect(on_reload)
	persist.load()
	update_ui()


func update_ui() -> void:
	for todo_item in parser.get_children():
		if todo_item is MarkdownTodoItem:
			add_todo_to_ui(todo_item)


func clean_box() -> void:
	for todo in box.get_children():
		box.remove_child(todo)
		todo.queue_free()


func add_todo_to_ui(todo_item: MarkdownTodoItem) -> void:
	var ui_item: MarkdownUIItem = ui_item.instantiate()
	todo_item.changed.connect(on_todo_changed.bind(ui_item, todo_item))
	ui_item.todo_item = todo_item
	box.add_child(ui_item)


func on_delete_item(ui_item: MarkdownUIItem, todo: MarkdownTodoItem) -> void:
	parser.remove_child(todo)
	clean_box()
	update_ui()
	persist.save()


func on_new_entry() -> void:
	var todo_item = parser.add_new_todo(new_entry_text_edit.text)
	add_todo_to_ui(todo_item)
	new_entry_text_edit.text = ""
	persist.save()


func on_reload() -> void:
	persist.load()
	clean_box()
	update_ui()


func on_todo_changed(ui_item: MarkdownUIItem, todo_item: MarkdownTodoItem) -> void:
	if todo_item.completed:
		move_child(todo_item, -1)
		box.move_child(ui_item, -1)

	persist.save()
