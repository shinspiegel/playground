class_name GameCamera extends Camera2D

@export var top_left: Node2D
@export var bottom_right: Node2D


func _ready() -> void:
	if top_left:
		limit_top = int(top_left.global_position.y)
		limit_left = int(top_left.global_position.x)
	else:
		push_warning("missing 'top_left' node")

	if bottom_right:
		limit_right = int(bottom_right.global_position.x)
		limit_bottom = int(bottom_right.global_position.y)
	else:
		push_warning("missing 'bottom_right' node")
