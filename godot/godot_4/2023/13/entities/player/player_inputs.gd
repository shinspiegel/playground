class_name PlayerInputs extends Node

var is_jump_just_pressed: bool = false
var is_jump_just_released: bool = false
var is_hide_just_pressed: bool = false
var is_interact_just_pressed: bool = false
var direction: float = 0.0
var last_direction: float = 0.0


func _physics_process(_delta: float) -> void:
	__reset()
	__apply_input_axis()
	__apply_jump()
	__apply_hide()
	__apply_interact()


func is_horizontal_zero() -> bool:
	return direction == 0.0


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


func __reset() -> void:
	is_jump_just_pressed = false
	is_jump_just_released = false
	is_hide_just_pressed = false
	direction = 0.0
