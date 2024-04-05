class_name Player extends BaseActor


func _physics_process(delta: float) -> void:
	apply_gravity(delta)

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		apply_jump()

	if is_on_floor():
		apple_direction(Input.get_axis("ui_left", "ui_right"), data.land_friction)
	else:
		apple_direction(Input.get_axis("ui_left", "ui_right"), data.air_friction)

	move_and_slide()

