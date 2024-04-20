class_name GameCamera extends Camera2D


func set_limit_list(list: Array[int]) -> void:
	limit_top = list[0]
	limit_left = list[1]
	limit_bottom = list[2]
	limit_right = list[3]
