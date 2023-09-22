extends Control

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var container: GridContainer = $Container
@onready var button: BaseButton = $Button


func _ready() -> void:
	__connect_nodes()
	button.focus_entered.connect(on_button_focus)
	button.pressed.connect(on_press)
	button.grab_focus()
	animated_sprite_2d.hide()


func on_press() -> void:
	GameManager.change_scene(GameManager.LEVELS.base_level)


func on_focus(node: Control) -> void:
	animated_sprite_2d.show()
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN)
	tween.tween_property(animated_sprite_2d, "global_position", node.global_position, 0.1)


func on_button_focus() -> void:
	animated_sprite_2d.hide()


func __connect_nodes() -> void:
	for node in container.get_children():
		if node is Control:
			node.focus_entered.connect(func(): on_focus(node))
