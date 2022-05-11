extends Control

# signal button_pressed(button_name)

export(NodePath) var initialSelection

onready var buttonsArea = $VBoxContainer/ButtonsArea


func _ready() -> void:
	var initial: Button = get_node(initialSelection)

	if initial:
		initial.grab_focus()
	elif buttonsArea.get_child_count() > 0:
		buttonsArea.get_children()[0].grab_focus()

	for button in buttonsArea.get_children():
		if button is ButtonExtra:
			button.connect("button_with_info_pressed", self, "pressed_button")


func pressed_button(button_name):
	# Create the match statement per button type here!
	print("aaaa", button_name)
	pass
