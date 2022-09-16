class_name ButtonExtra extends Button

signal button_with_info_pressed(button_name)


func _ready() -> void:
	var con = connect("button_down", self, "on_button_pressed_with_extra")
	if con != OK:
		print_debug("INFO:: Failed to connect [%s]" % [name])


func on_button_pressed_with_extra() -> void:
	emit_signal("button_with_info_pressed", self.name)
