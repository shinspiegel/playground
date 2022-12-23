class_name Witch extends CharacterBody2D

@export var run_data: RunData
@export var speed = 200.0
@export var direction: float = 0.0
@export var shoot: bool = false


func _physics_process(_delta: float) -> void:
	check_direction_keys()
	check_shoot_keys()
	
	apply_direction()
	apply_shoot()
	
	move_and_slide()


func apply_direction() -> void:
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed/10)


func apply_shoot() -> void:
	if shoot:
		print("shoot!")


func check_direction_keys() -> void:
	direction = Input.get_axis("left", "right")


func check_shoot_keys() -> void:
	shoot = Input.is_action_pressed("shot")
