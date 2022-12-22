class_name Menus extends CanvasLayer

var options = {}

func _ready() -> void:
	SignalBus.show_menu.connect(show_menu)
	SignalBus.hide_menu.connect(hide_menu)
	SignalBus.hide_all_menu.connect(hide_all)
	
	for node in get_children():
		options[node.name] = node
	
	hide_all()
	

func show_menu(menu: String) -> void:
	hide_all()
	if options.has(menu):
		options[menu].show()
		options[menu].grab_focus()
	else:
		print_debug("Failed to display meny [%s]" % [menu])


func hide_menu(menu: String) -> void:
	if options.has(menu):
		options[menu].hide()
	else:
		print_debug("Failed to display meny [%s]" % [menu])


func hide_all() -> void:
	for key in options.keys():
		options[key].hide()
