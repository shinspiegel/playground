class_name DisplayMessage extends Control

const PANEL_MOVE_DURATION = 0.3
const DELAY_TO_GRAB = 0.3
const CHAR_DURATION = 0.05
const BUTTON_DURATION = 0.3
const NEXT_BUTTON_VISIBLE_POS = Vector2(-240, -80)
const NEXT_BUTTON_OFFSET_POS = Vector2(100, -80)
const OPTION_BUTTONS_VISIBLE = [Vector2(-240, -200), Vector2(-240, -300), Vector2(-240, -400)]
const OPTION_BUTTONS_OFFSET_POS = [Vector2(100, -200), Vector2(100, -300), Vector2(100, -400)]
const DISPLAY_PANEL_VISIBLE = Vector2(-648, -336)
const DISPLAY_PANEL_OFFSET_POS = Vector2(-648, 72)

signal message_ended()
signal panel_showed()
signal panel_hidden()

@onready var profile_panel: Panel = %ProfilePanel
@onready var profile_image: TextureRect = %ProfileImage
@onready var profile_name: Label = %ProfileName
@onready var display_text_panel: Panel = %DisplayTextPanel
@onready var display_text: RichTextLabel = %DisplayText
@onready var next_button: Button = %NextButton
@onready var option_a: Button = %OptionA
@onready var option_b: Button = %OptionB
@onready var option_c: Button = %OptionC

var message_data: MessageData

func _ready() -> void:
	next_button.pressed.connect(on_button_press)
	option_a.hide()
	option_b.hide()
	option_c.hide()


func display(data: MessageData) -> void:
	message_data = data
	display_text_panel.show()

	if message_data.profile:
		profile_panel.show()
		profile_image.texture = message_data.profile.image
		profile_name.text = message_data.profile.name

	display_text.visible_ratio = 0.0
	display_text.text = message_data.text

	var tw: Tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(display_text, "visible_ratio", 1.0, (MessageManager.remove_bbcode(message_data.text).length() * CHAR_DURATION) / message_data.speed_ratio)
	tw.play()
	await tw.finished

	tw = create_tween().set_ease(Tween.EASE_IN_OUT).set_parallel(true)

	for entry: DisplayButtonItem in [
		DisplayButtonItem.new(message_data.option_a, option_a, OPTION_BUTTONS_VISIBLE[0]),
		DisplayButtonItem.new(message_data.option_b, option_b, OPTION_BUTTONS_VISIBLE[1]),
		DisplayButtonItem.new(message_data.option_c, option_c, OPTION_BUTTONS_VISIBLE[2]),
	]:
		if not entry.text.is_empty():
			entry.button.show()
			entry.button.text = entry.text

			if entry.button.pressed.is_connected(on_option_press):
				entry.button.pressed.disconnect(on_option_press)

			entry.button.pressed.connect(on_option_press.bind(entry.text))
			tw.tween_property(entry.button, "position", entry.pos, BUTTON_DURATION)

	if message_data.option_a.is_empty() and message_data.option_b.is_empty() and message_data.option_c.is_empty():
		next_button.show()
		tw.tween_property(next_button, "position", NEXT_BUTTON_VISIBLE_POS, BUTTON_DURATION)

	tw.play()
	await tw.finished

	await GameManager.create_timer(DELAY_TO_GRAB).timeout

	if option_a.visible:
		option_a.grab_focus()
	elif option_b.visible:
		option_b.grab_focus()
	elif option_c.visible:
		option_c.grab_focus()
	elif next_button.visible:
		next_button.grab_focus()


func reset() -> void:
	profile_panel.hide()

	display_text_panel.hide()
	display_text_panel.position = DISPLAY_PANEL_OFFSET_POS

	for entry: ButtonPositionItem in [
		ButtonPositionItem.new(next_button, NEXT_BUTTON_OFFSET_POS),
		ButtonPositionItem.new(option_a, OPTION_BUTTONS_OFFSET_POS[0]),
		ButtonPositionItem.new(option_b, OPTION_BUTTONS_OFFSET_POS[1]),
		ButtonPositionItem.new(option_c, OPTION_BUTTONS_OFFSET_POS[2]),
	]:
		entry.button.hide()
		entry.button.release_focus()
		entry.button.position = entry.pos

	display_text.visible_ratio = 0.0


func show_panel() -> void:
	reset()
	display_text_panel.show()

	var tw: Tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(display_text_panel, "position", DISPLAY_PANEL_VISIBLE, PANEL_MOVE_DURATION)
	tw.play()
	await tw.finished

	panel_showed.emit()


func hide_panel() -> void:
	var tw: Tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(display_text_panel, "position", DISPLAY_PANEL_OFFSET_POS, PANEL_MOVE_DURATION)
	tw.play()
	await tw.finished

	panel_hidden.emit()
	reset()


func on_button_press() -> void:
	next_button.hide()
	next_button.position = NEXT_BUTTON_OFFSET_POS
	profile_panel.hide()
	message_ended.emit()


func on_option_press(option: String) -> void:
	for entry: ButtonPositionItem in [
		ButtonPositionItem.new(option_a, OPTION_BUTTONS_OFFSET_POS[0]),
		ButtonPositionItem.new(option_b, OPTION_BUTTONS_OFFSET_POS[1]),
		ButtonPositionItem.new(option_c, OPTION_BUTTONS_OFFSET_POS[2]),
	]:
		entry.button.hide()
		entry.button.position = entry.pos

	profile_panel.hide()
	MessageManager.choose_option(message_data, option)
	message_ended.emit()


class ButtonPositionItem:
	var button: Button
	var pos: Vector2

	func _init(b: Button, p: Vector2) -> void:
		button = b
		pos = p

class DisplayButtonItem:
	var text: String
	var button: Button
	var pos: Vector2

	func _init(t: String, b: Button, p: Vector2) -> void:
		text = t
		button = b
		pos = p
