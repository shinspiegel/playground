class_name PlayerState extends BaseState

const IDLE = "Idle"
const MOVE = "Move"

const JUMP = "Jump"
const FALLING = "Falling"
const LAND = "Land"

const JAB = "Jab"
const AIR_JAB = "AirJab"
const ROLL = "Roll"

const HIT = "Hit"
const DIE = "Die"

const RANGED = "Ranged"
const AIR_RANGED = "AirRanged"
const BLOCK = "Block"
const DASH = "Dash"

@export var player: Player


func _ready() -> void:
	if player == null:
		push_error("missing player player node")

