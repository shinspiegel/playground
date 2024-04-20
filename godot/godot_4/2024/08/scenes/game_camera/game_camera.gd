class_name GameCamera extends Camera2D

@export var shake_str: float = 0.0
@export var shake_fade: float = 5.0


func _physics_process(delta: float) -> void:
	if shake_str > 0:
		offset = Vector2(randf_range(-shake_str, shake_str), randf_range(-shake_str, shake_str))
		shake_str = lerpf(shake_str, 0, shake_fade * delta)


func shake_damage(dmg: Damage) -> void:
	shake_str = dmg.amount * dmg.impact


func set_limit_list(list: Array[int]) -> void:
	limit_top = list[0]
	limit_left = list[1]
	limit_bottom = list[2]
	limit_right = list[3]
