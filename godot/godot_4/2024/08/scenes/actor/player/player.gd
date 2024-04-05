class_name Player extends BaseActor

@export var input: PlayerInput


func _physics_process(delta: float) -> void:
	apply_gravity(delta)

	if input.just_jump and is_on_floor():
		apply_jump()

	if is_on_floor():
		apple_direction(input.direction, data.land_friction)
	else:
		apple_direction(input.direction, data.air_friction)

	move_and_slide()
	check_flip(input.last_direction)

