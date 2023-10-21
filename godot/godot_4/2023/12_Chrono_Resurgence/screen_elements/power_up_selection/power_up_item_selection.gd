class_name PowerUpItemSelection extends Button

const texture_color_in  = Color(1.0, 1.0, 1.0, 1.0)
const texture_color_out = Color(1.0, 1.0, 1.0, 0.5)
const texture_color_dis = Color(0.5, 0.5, 0.5, 0.5)

@export var power_up: PlayerPowerUp

@export_group("Sound Effects")
@export var focus_sfx: AudioStream
@export var toggle_in_sfx: AudioStream
@export var toggle_out_sfx: AudioStream

@onready var animated_sprite_2d_2: AnimatedSprite2D = $ImagWrapper/AnimatedSprite2D2
@onready var icon_texture: TextureRect = $ImagWrapper/IconTexture
@onready var skill_name_label: Label = $HelperText/SkillName
@onready var description_label: Label = $HelperText/Description
@onready var cost_label: Label = $NinePatchRect/Cost


func _ready() -> void:
	__connect_inner_signals()
	__set_data_from_power_up()
	__define_initial_state()


func on_toggle(state: bool) -> void:
	if not is_disabled():
		if state:
			__set_effects(texture_color_in, true, toggle_in_sfx)
			
		else:
			__set_effects(texture_color_out, false, toggle_out_sfx)


func on_focus() -> void:
	__set_effects(texture_color_in, is_pressed(), focus_sfx)


func on_blur() -> void:
	if is_pressed():
		__set_effects(texture_color_in, true, null)
		
	else:
		__set_effects(texture_color_out, false, null)


func __connect_inner_signals() -> void:
	if not is_disabled():
		focus_entered.connect(on_focus)
		focus_exited.connect(on_blur)


func __define_initial_state() -> void:
	if is_pressed():
		__set_effects(texture_color_in, true, null)

	elif is_disabled():
		__set_effects(texture_color_dis, false, null)
		
	else:
		__set_effects(texture_color_out, false, null)


func __set_data_from_power_up() -> void:
	skill_name_label.text = power_up.power_up
	description_label.text = power_up.description
	cost_label.text = str(power_up.cost)
	
	button_pressed = power_up.is_selected
	
	if not power_up.is_enabled:
		disabled = true
		set_focus_mode(Control.FOCUS_NONE)
	else:
		disabled = false
		set_focus_mode(Control.FOCUS_ALL)
	
	icon_texture.texture = power_up.icon


func __set_effects(module_color: Color, enable_animate: bool = false, sfx_effect: AudioStream = null) -> void:
	icon_texture.modulate = module_color
	skill_name_label.modulate = module_color
	description_label.modulate = module_color
	
	if enable_animate:
		animated_sprite_2d_2.show()
	else:
		animated_sprite_2d_2.hide()
	
	if sfx_effect: 
		AudioManager.play_sfx(sfx_effect)
