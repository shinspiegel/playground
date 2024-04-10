class_name PlayerState extends BaseState

const IDLE = "Idle"
const MOVE = "Move"
const JUMP = "Jump"
const FALLING = "Falling"

@export var actor: Player


func _ready() -> void:
	if actor == null:
		push_error("missing player actor node")
