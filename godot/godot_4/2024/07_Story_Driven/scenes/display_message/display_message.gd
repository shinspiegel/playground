class_name DisplayMessage extends Control

const PANEL_MOVE_DURATION = 0.5
const CHAR_DURATION = 0.05
const BUTTON_DURATION = 0.1
const NEXT_BUTTON_OFFSET_POS = Vector2(112, -80)
const NEXT_BUTTON_VISIBLE_POS = Vector2(-208, -80)
const DISPLAY_PANEL_OFFSET_POS = Vector2(-648, 72)
const DISPLAY_PANEL_VISIBLE_POS = Vector2(-648, -336)

signal message_ended()
signal prepared()
signal unprepared()

@onready var profile_panel: Panel = %ProfilePanel
@onready var profile_image: TextureRect = %ProfileImage
@onready var profile_name: Label = %ProfileName
@onready var display_text_panel: Panel = %DisplayTextPanel
@onready var display_text: RichTextLabel = %DisplayText
@onready var next_button: Button = %NextButton

var regex = RegEx.new()


func _ready() -> void:
	regex.compile("\\[\\/?[^\\]]*\\]")
	next_button.pressed.connect(on_button_press)


func display(data: MessageData) -> void:
	display_text_panel.show()

	if data.profile:
		profile_panel.show()
		profile_image.texture = data.profile.image
		profile_name.text = data.profile.name

	display_text.visible_ratio = 0.0
	display_text.text = data.text

	var tw = create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(display_text, "visible_ratio", 1.0, (lenght_wihout_bbcode(data.text) * CHAR_DURATION) / data.speed_ratio)
	tw.play()
	await tw.finished

	next_button.show()

	tw = create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(next_button, "position", NEXT_BUTTON_VISIBLE_POS, BUTTON_DURATION)
	tw.play()
	await tw.finished

	next_button.grab_focus()


func reset() -> void:
	profile_panel.hide()

	display_text_panel.hide()
	display_text_panel.position = DISPLAY_PANEL_OFFSET_POS

	next_button.hide()
	next_button.release_focus()
	next_button.position = NEXT_BUTTON_OFFSET_POS

	display_text.visible_ratio = 0.0


func prepare() -> void:
	reset()
	display_text_panel.show()

	var tw = create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(display_text_panel, "position", DISPLAY_PANEL_VISIBLE_POS, PANEL_MOVE_DURATION)
	tw.play()
	await tw.finished

	prepared.emit()


func unprepare() -> void:
	var tw = create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(display_text_panel, "position", DISPLAY_PANEL_OFFSET_POS, PANEL_MOVE_DURATION)
	tw.play()
	await tw.finished

	unprepared.emit()
	reset()


func lenght_wihout_bbcode(text: String) -> int:
	var list = regex.search_all(text)

	for piece in list:
		var bb_code = piece.get_string()
		text = text.replace(bb_code, "")

	return text.length()


func on_button_press() -> void:
	next_button.hide()
	next_button.position = NEXT_BUTTON_OFFSET_POS

	profile_panel.hide()

	message_ended.emit()

