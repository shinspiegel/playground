extends Control

@onready var first: Button = %First
@onready var second: Button = %Second
@onready var back_menu: Button = %BackMenu


func _ready() -> void:
	first.pressed.connect(on_first)
	second.pressed.connect(on_second)
	back_menu.pressed.connect(on_back)
	back_menu.grab_focus()


func on_first() -> void:
	pass


func on_second() -> void:
	pass


func on_back() -> void:
	get_tree().change_scene_to_file("res://screens/start_menu/start_menu.tscn")
