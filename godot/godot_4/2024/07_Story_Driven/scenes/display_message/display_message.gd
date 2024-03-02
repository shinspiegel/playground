class_name DisplayMessage extends Control

enum {NEXT, OPTION_A, OPTION_B}

const DURATION = 0.3
const NEXT_BUTTON_START_POS = Vector2(112, -80)
const NEXT_BUTTON_END_POS = Vector2(-208, -80)
const DISPLAY_PANEL_START_POS = Vector2(-648, 72)
const DISPLAY_PANEL_END_POS = Vector2(-648, -336)

signal message_ended()

@onready var profile_panel: Panel = %ProfilePanel
@onready var profile_image: TextureRect = %ProfileImage
@onready var display_text_panel: Panel = %DisplayTextPanel
@onready var display_text: RichTextLabel = %DisplayText
@onready var next_button: Button = %NextButton


func _ready() -> void:
	next_button.pressed.connect(on_button_press)
	MessageManager.conversation_finished.connect(on_conversation_finish)


func display(data: MessageData) -> void:
	reset()

	display_text.text = data.message
	display_text_panel.show()
	next_button.show()

	var tw = create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(display_text_panel, "position", DISPLAY_PANEL_END_POS, DURATION)
	tw.play()
	await tw.finished

	tw = create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(display_text, "visible_ratio", 1.0, DURATION)
	tw.play()
	await tw.finished

	tw = create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(next_button, "position", NEXT_BUTTON_END_POS, DURATION)
	tw.play()
	await tw.finished

	next_button.grab_focus()


func reset() -> void:
	profile_panel.hide()

	display_text_panel.hide()
	display_text_panel.position = DISPLAY_PANEL_START_POS

	next_button.hide()
	next_button.release_focus()
	next_button.position = NEXT_BUTTON_START_POS

	display_text.visible_ratio = 0.0


func on_button_press() -> void:
	message_ended.emit()


func on_conversation_finish() -> void:
	reset()
