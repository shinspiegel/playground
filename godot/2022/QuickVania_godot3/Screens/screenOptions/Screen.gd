class_name Screen extends Control

signal button_with_detail_pressed(button_name)
signal toggle_checked(button_name, value)

export(NodePath) var initialSelection

onready var buttonsArea = $MarginContainer/VBoxContainer/ButtonsArea


func _ready() -> void:
	connect_all_buttons()


func connect_all_buttons() -> void:
	for item in buttonsArea.get_children():
		if item is ButtonExtra:
			connect_extra_button(item)
		if item is CheckButton:
			connect_check_button(item)


func connect_check_button(button: CheckButton) -> void:
	var con = button.connect("toggle_with_name", self, "on_toggle_pressed")

	if con != OK:
		print_debug("INFO:: Failed to connect")


func connect_extra_button(button: ButtonExtra) -> void:
	var con = button.connect("button_with_info_pressed", self, "on_button_with_detail_pressed")

	if con != OK:
		print_debug("INFO:: Failed to connect")


func default_focus() -> void:
	var initial: Button = get_node(initialSelection)

	if not initial == null:
		initial.grab_focus()
	elif buttonsArea.get_child_count() > 0:
		buttonsArea.get_children()[0].grab_focus()


func on_toggle_pressed(toggle_name: String, value: bool) -> void:
	emit_signal("toggle_checked", toggle_name, value)


func on_button_with_detail_pressed(button_name: String) -> void:
	emit_signal("button_with_detail_pressed", button_name)
