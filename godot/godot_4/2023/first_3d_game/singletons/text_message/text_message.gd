extends CanvasLayer

signal message_started()
signal message_ended()

@onready var container: Control = $MarginContainer
@onready var label: Label = $MarginContainer/HBoxContainer/Label
@onready var colddown: Timer = $TextColdown
@onready var picture: TextureRect = $MarginContainer/HBoxContainer/TextureRect

var is_active: bool = false

func _ready() -> void:
	PlayerInput.interacted.connect(close_message)
	is_active = true
	close_message()


func display_message(dialogue: DialogueMessage) -> void:
	if colddown.time_left <= 0 and not is_active:
		var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS).set_ease(Tween.EASE_OUT_IN)
		_clean_message()
		label.text = dialogue.message
		picture.texture = dialogue.icon
		is_active = true
		container.show()
		message_started.emit()
		print("created new tween")
		tween.tween_property(label, "visible_ratio", 1, 1)


func close_message() -> void:
	if is_active:
		is_active = false
		_clean_message()
		container.hide()
		message_ended.emit()
		colddown.start()


func _clean_message() -> void:
	label.text = ""
	label.visible_ratio = 0
	picture.texture = null
