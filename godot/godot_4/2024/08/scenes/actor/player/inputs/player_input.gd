class_name PlayerInput extends BaseInputs

const UP = "up"
const DOWN = "down"
const LEFT = "left"
const RIGHT = "right"
const JUMP = "jump"
const ROLL = "roll"
const JAB = "jab"
const RANGED = "ranged"
const BLOCK = "block"
const DASH = "dash"

@export var just_jump: bool = false
@export var just_release_jump: bool = false
@export var roll: bool = false
@export var attack: bool = false
@export var ranged: bool = false
@export var block: bool = false
@export var dash: bool = false


func _physics_process(_delta: float) -> void:
	down = Input.get_action_strength(DOWN)
	direction = Input.get_axis(LEFT, RIGHT)
	just_jump = Input.is_action_just_pressed(JUMP)
	just_release_jump = Input.is_action_just_released(JUMP)
	attack = Input.is_action_just_pressed(JAB)
	roll = Input.is_action_just_pressed(ROLL)
	ranged = Input.is_action_just_pressed(RANGED)
	block = Input.is_action_just_pressed(BLOCK)
	dash = Input.is_action_just_pressed(DASH)

	if direction != 0.0:
		last_direction = direction

