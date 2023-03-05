class_name GameCamera extends Camera2D

@export var top_left_marker: Marker2D
@export var bottom_right_marker: Marker2D


func _ready() -> void:
	set_camera_limits()


func set_camera_limits() -> void:
	limit_top = int(top_left_marker.global_position.y)
	limit_left = int(top_left_marker.global_position.x)
	limit_bottom = int(bottom_right_marker.global_position.y)
	limit_right = int(bottom_right_marker.global_position.x)
