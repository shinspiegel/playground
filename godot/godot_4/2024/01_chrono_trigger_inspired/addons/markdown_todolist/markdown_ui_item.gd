@tool
class_name MarkdownUIItem
extends Control

const active_color = Color(0.5, 0.5, 0, 1)
const deactive_color = Color(1, 1, 1, 1)
const completed_color = Color(0.5, 0.5, 0.5, 1)

@onready var check_box: CheckBox = $MarginContainer/Box/CheckBox
@onready var text_edit: MarkdownUITextEdit = $MarginContainer/Box/TextEdit
@onready var start: Button = $MarginContainer/Box/HBoxContainer/Start
@onready var stop: Button = $MarginContainer/Box/HBoxContainer/Stop
@onready var delete: Button = $MarginContainer/Box/HBoxContainer/Delete

var todo_item: MarkdownTodoItem
var start_time: float = 0.0

var is_started: bool = false:
	get: return is_started
	set(val):
		if val:
			modulate = active_color
			start.hide()
			stop.show()
		else:
			if todo_item.completed:
				modulate = completed_color
			else:
				modulate = deactive_color
			start.show()
			stop.hide()
		is_started = val


func _ready() -> void:
	text_edit.text = todo_item.content
	check_box.button_pressed = todo_item.completed

	if todo_item.completed:
		modulate = completed_color

	todo_item.changed.connect(on_todo_change)
	text_edit.returned.connect(on_update_text)
	check_box.pressed.connect(on_update_check_box)
	start.pressed.connect(on_start)
	stop.pressed.connect(on_stop)
	delete.pressed.connect(on_delete)

	start.show()
	stop.hide()


func on_update_text() -> void:
	todo_item.set_content(text_edit.text)


func on_update_check_box() -> void:
	if not is_started:
		if check_box.button_pressed:
			modulate = completed_color
		else:
			modulate = deactive_color

	todo_item.set_completed(check_box.button_pressed)


func on_start() -> void:
	start_time = Time.get_unix_time_from_system()
	is_started = true


func on_stop() -> void:
	todo_item.set_used_seconds(todo_item.get_used_seconds() + (Time.get_unix_time_from_system() - start_time))
	start_time = 0
	is_started = false


func on_delete() -> void:
	todo_item.delete_item()
	queue_free()


func on_todo_change() -> void:
	text_edit.text = todo_item.content
	check_box.button_pressed = todo_item.completed
