class_name ElementButton extends Button

const texture_color_in = Color(1,1,1,1)
const texture_color_out = Color(1,1,1,0.5)

@onready var animated_sprite_2d_2: AnimatedSprite2D = $ImagWrapper/AnimatedSprite2D2
@onready var texture_rect: TextureRect = $ImagWrapper/TextureRect


func _ready() -> void:
	focus_entered.connect(on_focus)
	focus_exited.connect(on_blur)
	toggled.connect(on_toggle)
	on_toggle(is_pressed())


func on_toggle(state: bool) -> void:
	if state:
		animated_sprite_2d_2.show()
		texture_rect.modulate = texture_color_in
	else:
		animated_sprite_2d_2.hide()
		texture_rect.modulate = texture_color_out


func on_focus() -> void:
	texture_rect.modulate = texture_color_in


func on_blur() -> void:
	if is_pressed():
		texture_rect.modulate = texture_color_in
	else:
		texture_rect.modulate = texture_color_out
