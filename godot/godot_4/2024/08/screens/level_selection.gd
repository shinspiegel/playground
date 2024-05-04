extends Control

@export var saved_data: SavedData

@onready var camera: Camera2D = %LevelCamera
@onready var beach_button: Button = %BeachButton
@onready var forest_button: Button = %ForestButton
@onready var vulcano_button: Button = %VuldanoButton

var __first_selection: bool = true
var __is_moving: bool = false


func _ready() -> void:
	beach_button.disabled = saved_data.beach_level_copleted
	forest_button.disabled = saved_data.forest_level_copleted
	vulcano_button.disabled = saved_data.vulcano_level_copleted

	__set_neighbor(beach_button, [forest_button, forest_button, forest_button, vulcano_button])
	__set_neighbor(forest_button, [beach_button, beach_button, vulcano_button, beach_button])
	__set_neighbor(vulcano_button, [forest_button, beach_button, beach_button, forest_button])

	for btn: Button in [beach_button, forest_button, vulcano_button]:
		btn.focus_entered.connect(on_focus.bind(btn))
		btn.pressed.connect(on_press.bind(btn))


func _physics_process(_delta: float) -> void:
	if __first_selection:
		__grab_first_direction()


func on_press(button: Button) -> void:
	match button.name:
		"ForestButton":
			SceneManager.change_to_file(SceneManager.SCENES.forest)

		"VulcanoButton":
			SceneManager.change_to_file(SceneManager.SCENES.forest)

		"BeachButton":
			SceneManager.change_to_file(SceneManager.SCENES.forest)



func on_focus(button: Button) -> void:
	if not __is_moving:
		__is_moving = true
		camera.global_position = button.global_position
		await __tween_zoom(Vector2(0.8, 0.8), 0.1).finished
		await __tween_zoom(Vector2(1,1), 0.3).finished
		__is_moving = false


func __grab_first_direction() -> void:
	if Input.is_action_just_pressed("ui_left"):
		__initial_move_to(vulcano_button)
		return

	if Input.is_action_just_pressed("ui_right"):
		__initial_move_to(beach_button)
		return

	if Input.is_action_just_pressed("ui_up"):
		__initial_move_to(forest_button)
		return

	if Input.is_action_just_pressed("ui_down"):
		__initial_move_to(beach_button)
		return


func __initial_move_to(button: Button) -> void:
	if not __is_moving:
		button.grab_focus()
		__first_selection = false
		__is_moving = true
		await __tween_zoom(Vector2(1,1), 0.5).finished
		__is_moving = false


func __tween_zoom(zoom: Vector2 = Vector2(1,1), duration: float = 1.0) -> Tween:
	var tw := create_tween()
	tw.tween_property(camera, "zoom", zoom, duration)
	tw.play()
	return tw


func __set_neighbor(button: Button, list: Array[Node]) -> void:
	button.focus_neighbor_top = list[0].get_path()
	button.focus_neighbor_bottom = list[1].get_path()
	button.focus_neighbor_left = list[2].get_path()
	button.focus_neighbor_right = list[3].get_path()
