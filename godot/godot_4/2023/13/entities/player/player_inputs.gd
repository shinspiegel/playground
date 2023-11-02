class_name PlayerInputs extends Node

var jump_press: bool = false
var jump_release: bool = false
var direction: float = 0.0
var last_direction: float = 0.0


func _physics_process(_delta: float) -> void:
	__reset()
	__apply_input_axis()
	__apply_jump()

func is_horizontal_zero() -> bool:
	return direction == 0.0


## Private Methods


func __apply_input_axis() -> void:
	direction = Input.get_axis("left", "right")
	
	if not direction == 0.0: 
		last_direction = direction


func __apply_jump() -> void:
	if Input.is_action_just_pressed("jump"):
		jump_press = true
	
	if Input.is_action_just_released("jump"):
		jump_release = true
	


func __reset() -> void:
	jump_press = false
	jump_release = false
	direction = 0.0
