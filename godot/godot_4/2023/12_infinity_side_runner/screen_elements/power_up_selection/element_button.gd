class_name ElementButton extends Button

const texture_color_in = Color(1,1,1,1)
const texture_color_out = Color(1,1,1,0.5)

@export var skill_name: String
@export var descriptions: String
@export var cost: int

@export_group("Sound Effects")
@export var focus_sfx: AudioStream
@export var toggle_in_sfx: AudioStream
@export var toggle_out_sfx: AudioStream

@onready var animated_sprite_2d_2: AnimatedSprite2D = $ImagWrapper/AnimatedSprite2D2
@onready var texture_rect: TextureRect = $ImagWrapper/TextureRect
@onready var skill_name_label: Label = $HelperText/SkillName
@onready var description_label: Label = $HelperText/Description
@onready var cost_label: Label = $NinePatchRect/Cost


func _ready() -> void:
	__connect_inner_signals()
	__define_initial_state()
	__set_label_text()


func on_toggle(state: bool) -> void:
	if state:
		animated_sprite_2d_2.show()
		texture_rect.modulate = texture_color_in
		AudioManager.play_sfx(toggle_in_sfx)
	else:
		animated_sprite_2d_2.hide()
		texture_rect.modulate = texture_color_out
		AudioManager.play_sfx(toggle_out_sfx)


func on_focus() -> void:
	texture_rect.modulate = texture_color_in
	AudioManager.play_sfx(focus_sfx)


func on_blur() -> void:
	if is_pressed():
		texture_rect.modulate = texture_color_in
	else:
		texture_rect.modulate = texture_color_out


func __connect_inner_signals() -> void:
	focus_entered.connect(on_focus)
	focus_exited.connect(on_blur)
	toggled.connect(on_toggle)


func __define_initial_state() -> void:
	if is_pressed():
		animated_sprite_2d_2.show()
		texture_rect.modulate = texture_color_in
	else:
		animated_sprite_2d_2.hide()
		texture_rect.modulate = texture_color_out


func __set_label_text() -> void:
	skill_name_label.text = skill_name
	description_label.text = descriptions
	cost_label.text = str(cost)
