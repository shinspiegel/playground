class_name PlayerInput extends BaseInputs


func _physics_process(_delta: float) -> void:
	direction = Input.get_axis("ui_left", "ui_right")
	just_jump = Input.is_action_just_pressed("ui_accept")

	if direction != 0.0:
		last_direction = direction

