class_name PlayerInput extends Node

@export var direction: Vector2 = Vector2.ZERO
@export var interact: bool = false
@export var just_interacted: bool = false

func _process(_delta: float) -> void:
	reset_all()
	get_direction()
	get_interact()


func get_direction() -> void:
	direction = Input.get_vector(
		"ui_left", 
		"ui_right", 
		"ui_up", 
		"ui_down"
	)


func get_interact() -> void:
	interact = Input.is_action_pressed("jump")
	just_interacted = Input.is_action_just_pressed("jump")


func reset_all() -> void:
	direction = Vector2.ZERO
	interact = false
	just_interacted = false
