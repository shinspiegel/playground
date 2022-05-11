class_name ButtonExtra extends Button

signal button_with_info_pressed(button_name)


func _ready() -> void:
	connect("button_down", self, "on_button_pressed_with_extra")


func on_button_pressed_with_extra() -> void:
	emit_signal("button_with_info_pressed", self.name)
