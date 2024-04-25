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
const BLOCK = "Block"
const DASH = "Dash"

@export var player: Player


func _ready() -> void:
	if player == null:
		push_error("missing player player node")

