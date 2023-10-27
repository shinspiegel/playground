extends CharacterBody2D

const MULTIPLIER = 100.0
const SPEED = 16.0 * MULTIPLIER
const JUMP_VELOCITY = 20.0 * MULTIPLIER
const GRAVITY = 100 * MULTIPLIER

@export var animation: AnimationPlayer

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if abs(velocity.x) > 0:
		animation.play("move")
	else:
		animation.play("idle")
	
	
	move_and_slide()
