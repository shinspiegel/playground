extends CanvasLayer

signal message_started()
signal message_ended()
signal option_selected(dialogue: DialogueMessage, option: String, index: int)

@export var button_scene: PackedScene

@onready var container: Control = $MarginContainer
@onready var label: Label = $MarginContainer/HBoxContainer/Label
@onready var colddown: Timer = $TextColdown
@onready var picture: TextureRect = $MarginContainer/HBoxContainer/TextureRect
@onready var options_area: VBoxContainer = $MarginContainer/Control/VBoxContainer

var is_active: bool = false
var dialogue: DialogueMessage


func _ready() -> void:
	PlayerInput.interacted.connect(on_input_press)
	is_active = true
	close_message()


func display_message(message: DialogueMessage) -> void:
	if colddown.time_left <= 0 and not is_active:
		get_tree().set_pause(true)
		dialogue = message
		_clean_message()
		_display_text_block()


func close_message() -> void:
	if is_active:
		get_tree().set_pause(false)
		is_active = false
		_clean_message()
		container.hide()
		message_ended.emit()
		colddown.start()


func on_input_press() -> void:
	if not dialogue == null and dialogue.options.size() <= 0:
		close_message()


func on_tween_finished() -> void:
	if dialogue.options.size() > 0:
		_create_buttons()
		options_area.get_child(0).grab_focus()


func _create_buttons() -> void:
	for index in range(dialogue.options.size()): 
		var option = dialogue.options[index]
		var btn: Button = button_scene.instantiate()
		btn.text = option
		btn.button_down.connect(func(): 
			option_selected.emit(dialogue, option, index)
			close_message()
		)
		options_area.add_child(btn)


func _display_text_block() -> void:
	var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS).set_ease(Tween.EASE_OUT_IN)
	label.text = dialogue.message
	picture.texture = dialogue.icon
	is_active = true
	container.show()
	message_started.emit()
	tween.tween_property(label, "visible_ratio", 1, 0.5)
	tween.finished.connect(on_tween_finished)


func _clean_message() -> void:
	label.text = ""
	label.visible_ratio = 0
	picture.texture = null
	for child in options_area.get_children():
		child.queue_free()
