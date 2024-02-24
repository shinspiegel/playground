class_name Player extends CharacterBody2D

const SPEED = 900.0
const JUMP_VELOCITY = -1400.0


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	apply_vertical_force()
	apply_horizontal_force()

	move_and_slide()


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta


func apply_vertical_force() -> void:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if not Input.is_action_pressed("ui_accept") and not is_on_floor() and velocity.y < 0:
		velocity.y = lerpf(velocity.y, 0, 0.2)



func apply_horizontal_force() -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
