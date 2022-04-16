extends KinematicBody2D

var motion : Vector2 = Vector2()
var direction : int = 1
var speed : int = 450

const GRAVITY : int = 10

func _physics_process(delta):
	motion.y = GRAVITY
	motion.x = speed * direction
	arrow_rotation()
	motion = move_and_slide(motion, Vector2(0,-1))

func arrow_rotation():
	if direction == 1 && rotation_degrees < 90:
		rotate(0.005)
	if direction == -1 && rotation_degrees > -90:
		rotate(-0.005)

func set_direction(newDirection : int):
	if (direction != newDirection):
		direction = newDirection
		var scale = Vector2(-1,1)
		apply_scale(scale)