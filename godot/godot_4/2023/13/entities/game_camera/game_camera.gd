class_name GameCamera extends Camera2D


func set_limiters(top: int, bottom: int, left: int, right: int) -> void:
	limit_top = top
	limit_bottom = bottom
	limit_left = left
	limit_right = right
