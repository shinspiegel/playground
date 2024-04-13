class_name PlayerInput extends BaseInputs

const LEFT = "ui_left"
const RIGHT = "ui_right"
const JUMP = "jump"
const JAB = "jab"
const ROLL = "roll"

@export var just_jump: bool = false
@export var just_release_jump: bool = false
@export var attack: bool = false
@export var roll: bool = false


func _physics_process(_delta: float) -> void:
	direction = Input.get_axis(LEFT, RIGHT)
	just_jump = Input.is_action_just_pressed(JUMP)
	just_release_jump = Input.is_action_just_released(JUMP)
	attack = Input.is_action_just_pressed(JAB)
	roll = Input.is_action_just_pressed(ROLL)

	if direction != 0.0:
		last_direction = direction

