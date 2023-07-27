class_name SelectableItem extends Button

signal selected(item: SelectableItem, state: bool)
signal actived(item: SelectableItem)
signal deactivated(item: SelectableItem)

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


func select(should_emit_signal: bool = true) -> void:
	is_selected = true
	background.color = selected_color
	if should_emit_signal: 
		selected.emit(self, is_selected)
		actived.emit(self)


func unselect(should_emit_signal: bool = true) -> void:
	is_selected = false
	background.color = unselected_color
	if should_emit_signal: 
		selected.emit(self, is_selected)
		deactivated.emit(self)


func set_data(new_text: String, new_texture: Texture2D) -> void:
	if new_text: title.text = new_text
	if new_texture: image.texture = new_texture
