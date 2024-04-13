class_name PlayerInput extends BaseInputs

const LEFT = "ui_left"
const RIGHT = "ui_right"
const JUMP = "ui_accept"


func _physics_process(_delta: float) -> void:
	direction = Input.get_axis(LEFT, RIGHT)
	just_jump = Input.is_action_just_pressed(JUMP)

	if direction != 0.0:
		last_direction = direction

