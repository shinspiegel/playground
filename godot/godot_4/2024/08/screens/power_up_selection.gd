extends Control

const TEXT_SPEED = 0.02

@onready var creation_button: Button = %Creation
@onready var evocation_button: Button = %Evocation
@onready var transmutation_button: Button = %Transmutation
@onready var description_panel: Panel = %DescriptionPanel
@onready var description_label: Label = %Description

var __first_selection: bool = true
var __text_tween: Tween


func _ready() -> void:
	description_panel.modulate = Color(1,1,1,0)
	description_label.text = ""
	description_label.visible_ratio = 0.0

	__set_neighbor(creation_button, [transmutation_button, evocation_button, transmutation_button, evocation_button])
	__set_neighbor(evocation_button, [creation_button, transmutation_button, creation_button, transmutation_button])
	__set_neighbor(transmutation_button, [evocation_button, creation_button, evocation_button, creation_button])

	for btn: Button in [creation_button, evocation_button, transmutation_button]:
		btn.focus_entered.connect(on_focus_enter.bind(btn))
		btn.pressed.connect(on_press.bind(btn))


func _physics_process(_delta: float) -> void:
	if __first_selection:
		__grab_first_direction()


func on_focus_enter(button: Button) -> void:
	if not __text_tween == null:
		__text_tween.stop()
	__text_tween = create_tween()
	description_label.text = ""
	description_label.visible_ratio = 0.0

	match button.name:
		"Creation":
			description_label.text = "Use the power of creation magic to conjure a block to use as platform for traverse the environment. It can be used to block incoming ranged attacks."
			__text_tween.tween_property(description_label, "visible_ratio", 1.0, description_label.text.length() * TEXT_SPEED)

		"Evocation":
			description_label.text = "Harvest the water and air around to create a high pressure projectile to hit targets at distance."
			__text_tween.tween_property(description_label, "visible_ratio", 1.0, description_label.text.length() * TEXT_SPEED)

		"Transmutation":
			description_label.text = "Use magical energy on your body to leap forward with powerful dash."
			__text_tween.tween_property(description_label, "visible_ratio", 1.0, description_label.text.length() * TEXT_SPEED)

	__text_tween.play()


func on_press(button: Button) -> void:
	print(button.name)


func __grab_first_direction() -> void:
	if Input.is_action_just_pressed("ui_left"):
		creation_button.grab_focus()
		__first_selection = false
		__make_panel_visible()
		return

	if Input.is_action_just_pressed("ui_right"):
		transmutation_button.grab_focus()
		__first_selection = false
		__make_panel_visible()
		return

	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
		evocation_button.grab_focus()
		__first_selection = false
		__make_panel_visible()
		return


func __set_neighbor(button: Button, list: Array[Node]) -> void:
	button.focus_neighbor_top = list[0].get_path()
	button.focus_neighbor_bottom = list[1].get_path()
	button.focus_neighbor_left = list[2].get_path()
	button.focus_neighbor_right = list[3].get_path()


func __make_panel_visible() -> void:
	var tw := create_tween()
	tw.tween_property(description_panel, "modulate", Color(1,1,1,1), 0.5)
	tw.play()
