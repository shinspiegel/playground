extends KinematicBody2D

class_name Character

export(int) var HIT_POINTS := 1
export(int) var MAX_SPEED := 80
export(int) var ACCELERATION := 700
export(int) var JUMP_FORCE := 200
export(int) var GRAVITY := 400
export(float) var FRICTION := 0.4

onready var sprite: Sprite = $Sprite
onready var collider: CollisionShape2D = $Collider
onready var animationPlayer: AnimationPlayer = $AnimationPlayer

var motion := Vector2.ZERO
var flip_direction: int = 1


func apply_horizontal_speed(input: Vector2, delta: float):
	if input.x != 0:
		motion.x += input.x * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)


func apply_vertical_speed(input: Vector2, delta: float):
	if input.y != 0:
		motion.y = input.y * JUMP_FORCE


func apply_gravity(delta: float):
	motion.y += GRAVITY * delta
	motion.y = min(motion.y, JUMP_FORCE)


func apply_friction(input: Vector2):
	if input.x == 0 and is_on_floor():
		motion.x = lerp(motion.x, 0, FRICTION)


func apply_flip_scale(value: int):
	if value != 0:
		if value > 0 and flip_direction == -1:
			scale.x *= -1
			flip_direction = 1
		if value < 0 and flip_direction == 1:
			scale.x *= -1
			flip_direction = -1


func apply_move(speed_scale: Vector2 = Vector2.ONE):
	motion.x *= speed_scale.x
	motion.y *= speed_scale.y
	motion = move_and_slide(motion, Vector2.UP)


func apply_all(input: Vector2, delta: float):
	apply_horizontal_speed(input, delta)
	apply_vertical_speed(input, delta)
	apply_gravity(delta)
	apply_friction(input)
	apply_flip_scale(input.x)


func die() -> void:
	queue_free()


func update_animation(animation:String, speed_scale: float = 1.0):
	animationPlayer.play(animation)
	animationPlayer.set_speed_scale(speed_scale)


func check_death() -> void:
	if HIT_POINTS <= 0:
		die()	


func take_damage(damage: int) -> void:
	HIT_POINTS -= damage
	check_death()


func _on_HurtBox_hit(damage: int) -> void:
	take_damage(damage)


func animation_finished(animation: String) -> void:
	pass
