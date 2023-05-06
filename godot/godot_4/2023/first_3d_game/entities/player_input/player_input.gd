class_name PlayerInput extends Node

signal interacted()
signal next_dialogue()

@export var direction: Vector2 = Vector2.ZERO
@export var interact: bool = false
@export var just_interacted: bool = false
@export var dialogue_next: bool = false


func _process(_delta: float) -> void:
	reset_all()
	get_direction()
	get_interact()
	get_dialogue_next()


func get_direction() -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func get_interact() -> void:
	interact = Input.is_action_pressed("jump")
	just_interacted = Input.is_action_just_pressed("jump")
	interacted.emit()


func get_dialogue_next() -> void:
	if Input.is_action_just_pressed("jump") or \
		Input.is_action_just_pressed("move_back") or \
		Input.is_action_just_pressed("move_forward") or \
		Input.is_action_just_pressed("move_left") or \
		Input.is_action_just_pressed("move_right"):
			dialogue_next = true
			next_dialogue.emit()

func reset_all() -> void:
	direction = Vector2.ZERO
	interact = false
	just_interacted = false
	dialogue_next = false
