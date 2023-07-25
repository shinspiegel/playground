class_name SelectableItem extends Button

signal selected(item)

@export var selected_color: Color = Color(1,1,1)
@export var unselected_color: Color = Color(0,0,0)

@onready var background: ColorRect = %Background
@onready var image: TextureRect = %Image
@onready var title: Label = %Title

var is_selected: bool = false

func _ready() -> void:
	background.color = unselected_color
	pressed.connect(toggle)


func toggle() -> void:
	if not is_selected:
		select()
	else:
		unselect()


func select() -> void:
	is_selected = true
	background.color = selected_color
	selected.emit(self)


func unselect() -> void:
	is_selected = false
	background.color = unselected_color
