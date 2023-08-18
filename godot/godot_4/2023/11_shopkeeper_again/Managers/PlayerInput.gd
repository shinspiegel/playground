extends Node

const UP = "up"
const DOWN = "down"
const LEFT = "left"
const RIGHT = "right"

const CROSS = "cross"
const SQUARE = "square"
const TRIANGLE = "triangle"
const CIRCLE = "circle"

const OPTIONS = "options"

signal action_pressed(action: String)
signal cross_pressed()
signal square_pressed()
signal triangle_pressed()
signal circle_pressed()
signal options_pressed()

@export var direction: Vector2 = Vector2.ZERO
@export var cross: bool = false
@export var square: bool = false
@export var triangle: bool = false
@export var circle: bool = false
@export var options: bool = false

func _process(_delta: float) -> void:
	__update_direction()
	__update_action_buttons()
	__update_action_signals()


func __update_direction() -> void:
	direction = Input.get_vector(LEFT, RIGHT, UP, DOWN)


func __update_action_buttons() -> void:
	cross = Input.is_action_pressed(CIRCLE)
	square = Input.is_action_pressed(SQUARE)
	triangle = Input.is_action_pressed(TRIANGLE)
	circle = Input.is_action_pressed(CIRCLE)
	
	options = Input.is_action_pressed(OPTIONS)


func __update_action_signals() -> void:
	for action in [CROSS, SQUARE, TRIANGLE, CIRCLE, OPTIONS]:
		if Input.is_action_just_pressed(action):
			action_pressed.emit(action)
			
			match action:
				CROSS: cross_pressed.emit()
				SQUARE: square_pressed.emit()
				TRIANGLE: triangle_pressed.emit()
				CIRCLE: circle_pressed.emit()
				OPTIONS: options_pressed.emit()
