class_name PlayerInput extends BaseInputs

const LEFT = "ui_left"
const RIGHT = "ui_right"
const JUMP = "jump"
const JAB = "jab"


func _physics_process(_delta: float) -> void:
	direction = Input.get_axis(LEFT, RIGHT)
	just_jump = Input.is_action_just_pressed(JUMP)
	just_release_jump = Input.is_action_just_released(JUMP)
	attack = Input.is_action_pressed(JAB)

	if direction != 0.0:
		last_direction = direction

