extends Control

@export var game_data: GameData

@onready var first: Button = %First
@onready var second: Button = %Second
@onready var back_menu: Button = %BackMenu
@onready var item_1: Button = %Item1
@onready var item_2: Button = %Item2
@onready var item_3: Button = %Item3



func _ready() -> void:
	first.pressed.connect(on_level_select.bind("res://levels/testing_level.tscn"))
	second.pressed.connect(on_level_select.bind("res://levels/testing_level.tscn"))
	back_menu.pressed.connect(on_back)

	__enable_unlocked_items()
	__select_current()

	back_menu.grab_focus()



func on_level_select(path: String) -> void:
	__update_item_selected()
	SceneManager.change_to_file(path)


func on_back() -> void:
	SceneManager.change_to_file("res://screens/start_menu/start_menu.tscn")



# PRIVATE METHODS


func __enable_unlocked_items() -> void:
	item_1.set_disabled(true)
	item_2.set_disabled(true)
	item_3.set_disabled(true)

	if game_data.item_1_unlock: item_1.set_disabled(false)
	if game_data.item_2_unlock: item_2.set_disabled(false)
	if game_data.item_3_unlock: item_3.set_disabled(false)


func __select_current() -> void:
	match game_data.item_current:
		1: item_1.set_pressed(true)
		2: item_2.set_pressed(true)
		3: item_3.set_pressed(true)
		_: pass


func __update_item_selected() -> void:
	if item_1.is_pressed():
		game_data.set_item(1)
	elif item_2.is_pressed():
		game_data.set_item(2)
	elif item_3.is_pressed():
		game_data.set_item(3)

