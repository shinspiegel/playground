@tool
class_name MarkdownUITextEdit
extends TextEdit

signal returned()
var is_editing: bool = false

func _ready() -> void:
	focus_entered.connect(func(): is_editing = true)
	focus_exited.connect(func(): is_editing = false)


func _input(event: InputEvent) -> void:
	if is_editing and event is InputEventKey and event.is_pressed() and not event.is_echo():
		if event.keycode == KEY_ENTER:
			returned.emit()
			is_editing = false
			get_viewport().set_input_as_handled()
			call_deferred("release_focus")
