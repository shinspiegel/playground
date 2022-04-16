extends Node2D
class_name PlayerInput

var direction: Vector2 = Vector2.ZERO
var jump: bool = false


func _unhandled_input(event):
	if event.is_action_pressed("right"):
		direction.x += 1
	if event.is_action_released("right"):
		direction.x -= 1
	
	if event.is_action_pressed("left"):
		direction.x -= 1
	if event.is_action_released("left"):
		direction.x += 1
	
	if event.is_action_pressed("jump"):
		jump = true
	if event.is_action_released("jump"):
		jump = false
