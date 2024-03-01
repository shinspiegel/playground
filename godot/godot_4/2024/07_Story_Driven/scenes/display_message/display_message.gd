class_name DisplayMessage extends Control

@onready var profile_panel: Panel = %ProfilePanel
@onready var profile_image: TextureRect = %ProfileImage
@onready var display_text_panel: Panel = %DisplayTextPanel
@onready var display_text: RichTextLabel = %DisplayText
@onready var next_button: Button = %NextButton
@onready var option_a: Button = %OptionA
@onready var option_b: Button = %OptionB


func _ready() -> void:
	reset()


func display(message) -> void:
	print(message)


func reset() -> void:
	profile_panel.hide()
	display_text_panel.hide()
	next_button.hide()
	option_a.hide()
	option_b.hide()

