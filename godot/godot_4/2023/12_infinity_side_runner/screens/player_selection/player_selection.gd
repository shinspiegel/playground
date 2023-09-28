extends Control

const ITEM_SELECTION = preload("res://screen_elements/power_up_selection/power_up_item_selection.tscn")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var container: GridContainer = $Container
@onready var button: BaseButton = $Button


func _ready() -> void:
	__create_item_nodes()
	button.focus_entered.connect(on_button_focus)
	button.pressed.connect(on_start_run_press)
	button.grab_focus()
	animated_sprite_2d.hide()


func on_start_run_press() -> void:
	SceneManager.change_scene("city_level")


func on_item_selection_focus(node: Control) -> void:
	animated_sprite_2d.show()
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN)
	tween.tween_property(animated_sprite_2d, "global_position", node.global_position, 0.1)


func on_button_focus() -> void:
	animated_sprite_2d.hide()


func __create_item_nodes() -> void:
	for power_up in PlayerData.get_power_up_list():
		var node: PowerUpItemSelection = ITEM_SELECTION.instantiate()
		
		node.skill_name = power_up.power_up
		node.descriptions = power_up.description
		node.cost = power_up.cost
		node.set_pressed(power_up.is_selected)
		node.focus_entered.connect(func(): on_item_selection_focus(node))
		node.toggled.connect(func(state: bool): __toggle_power_up(power_up, node, state))
		
		container.add_child(node)


func __toggle_power_up(power_up: PlayerPowerUp, node: PowerUpItemSelection, state: bool) -> void:
	power_up.is_selected = state
	node.set_pressed(state)
	
	# Validate that can toggle // if state == true
	node.on_toggle(state)
	# toggle off!
