class_name Screen extends Control

signal button_with_detail_pressed(button_name)

export(NodePath) var initialSelection

onready var buttonsArea = $MarginContainer/VBoxContainer/ButtonsArea


func _ready() -> void:
	connect_all_buttons()


func connect_all_buttons() -> void:
	for button in buttonsArea.get_children():
		if button is ButtonExtra:
			connect_button(button)


func connect_button(button: ButtonExtra) -> void:
	var con = button.connect("button_with_info_pressed", self, "on_button_with_detail_pressed")

	if con != OK:
		print_debug("INFO:: Failed to connect")


func default_focus() -> void:
	var initial: Button = get_node(initialSelection)

	if not initial == null:
		initial.grab_focus()
	elif buttonsArea.get_child_count() > 0:
		buttonsArea.get_children()[0].grab_focus()


func on_button_with_detail_pressed(button_name):
	emit_signal("button_with_detail_pressed", button_name)
