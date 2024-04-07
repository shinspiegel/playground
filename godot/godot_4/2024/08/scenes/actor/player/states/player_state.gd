class_name PlayerState extends BaseState

@export var actor: Player


func _ready() -> void:
	if actor == null:
		push_error("missing player actor node")
