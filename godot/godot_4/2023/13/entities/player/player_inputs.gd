class_name PlayerInputs extends BaseInputs


func _physics_process(_delta: float) -> void:
	reset()
	__apply_input_axis()
	__apply_attack()
	__apply_jump()
	__apply_hide()
	__apply_interact()


## Private Methods


func __apply_input_axis() -> void:
	direction = Input.get_axis("left", "right")

	if not direction == 0.0:
		last_direction = direction


func __apply_jump() -> void:
	if Input.is_action_just_pressed("jump"):
		is_jump_just_pressed = true

	if Input.is_action_just_released("jump"):
		is_jump_just_released = true



func __apply_hide() -> void:
	if Input.is_action_just_pressed("hide"):
		is_hide_just_pressed = true


func __apply_interact() -> void:
	if Input.is_action_just_pressed("interact"):
		is_interact_just_pressed = true


func __apply_attack() -> void:
	if Input.is_action_just_pressed("attack"):
		is_attack_just_pressed = true
