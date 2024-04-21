class_name PlayerState extends BaseState

const IDLE = "Idle"
const MOVE = "Move"
const JUMP = "Jump"
const FALLING = "Falling"
const LAND = "Land"
const JAB = "Jab"
const ROLL = "Roll"
const HIT = "Hit"
const DIE = "Die"
const RANGED = "Ranged"

@export var actor: Player


func _ready() -> void:
	if actor == null:
		push_error("missing player actor node")

