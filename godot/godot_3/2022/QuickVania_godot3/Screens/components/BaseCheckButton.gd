extends CheckButton

signal toggle_with_name(togggle_name, value)

export var initial_text: String


func _ready() -> void:
	connect_toggle()
	update_text()


func update_text() -> void:
	var append = " " + get_append()
	text = initial_text + append


func get_append() -> String:
	if pressed:
		return "is ON"
	else:
		return "is OFF"


func connect_toggle() -> void:
	var con = connect("toggled", self, "on_toggle_with_name")
	if con != OK:
		print_debug("INFO:: Failed to connect [%s]" % [name])


func on_toggle_with_name(value: bool) -> void:
	emit_signal("toggle_with_name", self.name, value)
	update_text()
