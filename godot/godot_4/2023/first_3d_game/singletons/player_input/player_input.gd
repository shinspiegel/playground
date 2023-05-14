extends Node

signal interacted()

@export var direction: Vector2 = Vector2.ZERO
@export var interact: bool = false
@export var just_interacted: bool = false

@onready var interact_colddown: Timer = $InteractColdown


func _process(_delta: float) -> void:
	reset_all()
	get_direction()
	get_interact()
	apply_colddown()


func apply_colddown() -> void:
	if interact or just_interacted:
		interact_colddown.start()


func get_direction() -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")


func get_interact() -> void:
	if interact_colddown.time_left <= 0:
		interact = Input.is_action_pressed("jump")
		just_interacted = Input.is_action_just_pressed("jump")
		
		if just_interacted:
			interacted.emit()


func reset_all() -> void:
	direction = Vector2.ZERO
	interact = false
	just_interacted = false
