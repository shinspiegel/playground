class_name Witch extends CharacterBody2D

var direction = Vector2.ZERO


func _physics_process(delta: float) -> void:
	check_direction_keys()
	check_shoot_keys()


func check_direction_keys() -> void:
	pass


func check_shoot_keys() -> void:
	pass
