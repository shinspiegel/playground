extends KinematicBody2D

export(int) var MAX_SPEED = 15
export(int) var HP = 1
var motion = Vector2.ZERO


func _on_HurtBox_hit(damage) -> void:
	HP -= damage
	
	if HP < 1:
		queue_free()
